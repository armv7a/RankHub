import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amap_map/amap_map.dart' as amap;
import 'package:x_amap_base/x_amap_base.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:rank_hub/models/nearcade/shop.dart';
import 'package:rank_hub/routes/app_routes.dart';
import 'package:rank_hub/services/nearcade_api_service.dart';
import 'package:rank_hub/widgets/nearcade/shop_card.dart';
import 'package:rank_hub/widgets/nearcade/quick_filters.dart';
import 'dart:ui';

class NearcadePage extends StatefulWidget {
  const NearcadePage({super.key});

  @override
  State<NearcadePage> createState() => _NearcadePageState();
}

class _NearcadePageState extends State<NearcadePage> {
  amap.AMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  final NearcadeApiService _apiService = NearcadeApiService();

  LatLng _currentPosition = LatLng(23.12463, 113.36211); // 默认广州市中心
  bool _isLoadingLocation = true;
  double _sheetSize = 0.3; // 跟踪 sheet 当前大小
  int _logoBottomMargin = 0; // Logo底部边距
  bool _isSearchFocused = false; // 搜索框是否有焦点

  List<Shop> _shops = [];
  List<Shop> _filteredShops = []; // 筛选后的店铺列表
  String _currentFilter = 'recommended'; // 当前筛选器
  Set<amap.Marker> _markers = {};
  bool _isLoadingShops = true;
  String? _error;
  Shop? _selectedShop; // 选中的店铺
  double _searchRadius = 10.0; // 探索半径，单位km

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();

    // 监听搜索框焦点变化
    _searchFocusNode.addListener(() {
      if (mounted) {
        setState(() {
          _isSearchFocused = _searchFocusNode.hasFocus;
        });
      }
    });

    // 监听 sheet 大小变化
    _sheetController.addListener(() {
      if (_sheetController.isAttached) {
        if (mounted) {
          setState(() {
            _sheetSize = _sheetController.size;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _mapController?.disponse();
    _sheetController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // 检查位置服务是否启用
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (!mounted) return;
        setState(() => _isLoadingLocation = false);
        Get.snackbar(
          '提示',
          '位置服务未启用',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
        );
        return;
      }

      // 检查位置权限
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (!mounted) return;
          setState(() => _isLoadingLocation = false);
          Get.snackbar(
            '提示',
            '位置权限被拒绝',
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(16),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (!mounted) return;
        setState(() => _isLoadingLocation = false);
        Get.snackbar(
          '提示',
          '位置权限被永久拒绝，请在设置中开启',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
        );
        return;
      }

      // 获取当前位置
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      );

      if (!mounted) return;
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _isLoadingLocation = false;
      });

      // 移动地图到当前位置
      _mapController?.moveCamera(amap.CameraUpdate.newLatLng(_currentPosition));

      // 获取位置后加载附近店铺
      _loadShops();
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoadingLocation = false);
      Get.snackbar(
        '错误',
        '获取位置失败: $e',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    }
  }

  Future<void> _loadShops() async {
    if (mounted) {
      setState(() {
        _isLoadingShops = true;
        _error = null;
      });
    }

    try {
      final response = await _apiService.discoverNearby(
        longitude: _currentPosition.longitude,
        latitude: _currentPosition.latitude,
        radius: _searchRadius, // 使用当前设置的探索半径
        fetchAttendance: true,
      );
      final markers = response.shops
          .map(
            (shop) => amap.Marker(
              position: LatLng(shop.location.latitude, shop.location.longitude),
              infoWindow: amap.InfoWindow(title: shop.name),
            ),
          )
          .toSet();

      if (!mounted) return;
      setState(() {
        _shops = response.shops;
        _filteredShops = _applyFilter(_shops, _currentFilter);
        _isLoadingShops = false;
        _markers = markers;
      });

      // 自动将相机移动到推荐的第一个机厅
      if (_filteredShops.isNotEmpty && _mapController != null) {
        final firstShop = _filteredShops[0];
        final target = LatLng(
          firstShop.location.latitude,
          firstShop.location.longitude,
        );
        _mapController!.moveCamera(amap.CameraUpdate.newLatLngZoom(target, 16));
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoadingShops = false;
      });
      Get.snackbar(
        '错误',
        '加载店铺失败: $e',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    }
  }

  List<Shop> _applyFilter(List<Shop> shops, String filter) {
    final sortedShops = List<Shop>.from(shops);

    switch (filter) {
      case 'recommended':
        // 推荐：距离权重 > 热门权重
        sortedShops.sort((a, b) {
          final distanceA = a.distance ?? double.infinity;
          final distanceB = b.distance ?? double.infinity;
          final gamesA = a.games.length;
          final gamesB = b.games.length;

          // 计算综合得分：距离权重60%，热门权重40%
          // 距离越近分数越高，游戏越多分数越高
          final scoreA = (1 / (distanceA + 0.1)) * 0.6 + gamesA * 0.4;
          final scoreB = (1 / (distanceB + 0.1)) * 0.6 + gamesB * 0.4;

          return scoreB.compareTo(scoreA);
        });
        break;

      case 'nearest':
        // 最近：按距离排序
        sortedShops.sort((a, b) {
          final distanceA = a.distance ?? double.infinity;
          final distanceB = b.distance ?? double.infinity;
          return distanceA.compareTo(distanceB);
        });
        break;

      case 'popular':
        // 热门：按游戏数量排序
        sortedShops.sort((a, b) => b.games.length.compareTo(a.games.length));
        break;

      case 'open':
        // 营业中：只显示营业中的店铺，然后按距离排序
        final openShops = sortedShops.where((shop) => shop.isOpen).toList();
        openShops.sort((a, b) {
          final distanceA = a.distance ?? double.infinity;
          final distanceB = b.distance ?? double.infinity;
          return distanceA.compareTo(distanceB);
        });
        return openShops;
    }

    return sortedShops;
  }

  void _onFilterSelected(String filter) {
    if (mounted) {
      setState(() {
        _currentFilter = filter;
        _filteredShops = _applyFilter(_shops, filter);
      });
    }

    // 自动将相机移动到推荐的第一个机厅
    if (_filteredShops.isNotEmpty && _mapController != null) {
      final firstShop = _filteredShops[0];
      final target = LatLng(
        firstShop.location.latitude,
        firstShop.location.longitude,
      );
      _mapController!.moveCamera(amap.CameraUpdate.newLatLngZoom(target, 16));
    }
  }

  void _onMapCreated(amap.AMapController controller) {
    if (mounted) {
      setState(() {
        _mapController = controller;
      });
    }

    // 如果已经获取到位置，移动到当前位置
    if (!_isLoadingLocation) {
      controller.moveCamera(amap.CameraUpdate.newLatLng(_currentPosition));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // 地图
          amap.AMapWidget(
            onMapCreated: _onMapCreated,
            initialCameraPosition: amap.CameraPosition(
              target: _currentPosition,
              zoom: 15,
            ),
            mapType: isDarkMode ? amap.MapType.night : amap.MapType.normal,
            buildingsEnabled: true,
            compassEnabled: false,
            scaleEnabled: true,
            logoPosition: LogoPosition.BOTTOM_LEFT,
            markers: _markers,
          ),

          // 状态栏模糊效果
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).padding.top,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.3),
                ),
              ),
            ),
          ),

          // 所有机厅按钮
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 16,
            child: Material(
              borderRadius: BorderRadius.circular(12),
              elevation: 4,
              child: InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.allShops);
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.list,
                        size: 20,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '所有机厅',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 数据来源标识
          Positioned(
            left: 16,
            bottom: _logoBottomMargin + 16.0,
            child: Opacity(
              opacity: _sheetSize < 0.4 ? 1.0 : 0.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 18,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 10,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                    const SizedBox(width: 4),
                    Text('数据来源: ', style: TextStyle(fontSize: 8)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF0EA5E9), // sky-500
                              Color(0xFFA855F7), // purple-500
                              Color(0xFFF43F5E), // rose-500
                            ],
                          ).createShader(bounds),
                          child: Text(
                            'near',
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: const Offset(1, 1),
                                  blurRadius: 2,
                                  color: Colors.black.withOpacity(0.3),
                                ),
                                Shadow(
                                  offset: const Offset(-1, -1),
                                  blurRadius: 2,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          'cade',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 浮动店铺卡片
          if (_selectedShop != null)
            Positioned(
              top: MediaQuery.of(context).padding.top + 80,
              left: 16,
              right: 16,
              child: _buildFloatingShopCard(_selectedShop!),
            ),

          // 定位按钮
          if (_sheetSize < 0.8)
            Positioned(
              right: 16,
              bottom: MediaQuery.of(context).size.height * _sheetSize + 16,
              child: Material(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                elevation: 4,
                child: InkWell(
                  onTap: _isLoadingLocation ? null : _getCurrentLocation,
                  onLongPress: _showRadiusDialog,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: _isLoadingLocation
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          )
                        : Icon(
                            Icons.my_location,
                            size: 24,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                  ),
                ),
              ),
            ),

          // 遮罩层（当sheet从0.5到0.9时逐渐显示）
          if (_sheetSize > 0.5)
            Positioned.fill(
              child: IgnorePointer(
                child: Opacity(
                  opacity: ((_sheetSize - 0.5) / 0.4).clamp(0.0, 1.0) * 0.5,
                  child: Container(color: Colors.black),
                ),
              ),
            ),

          // 可拖拽的底部 Sheet
          NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              // 当搜索框有焦点时，禁止拖拽
              return _isSearchFocused;
            },
            child: DraggableScrollableSheet(
              controller: _sheetController,
              initialChildSize: 0.5,
              minChildSize: 0.2,
              maxChildSize: 0.9,
              snap: true,
              snapSizes: const [0.2, 0.5, 0.9],
              builder: (context, scrollController) {
                // 当sheet停靠完成时更新logoBottomMargin
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_sheetController.isAttached) {
                    final currentSize = _sheetController.size;
                    final screenHeight = MediaQuery.of(context).size.height;
                    final newMargin = (screenHeight * currentSize).toInt();
                    if (_logoBottomMargin != newMargin) {
                      setState(() {
                        _logoBottomMargin = newMargin;
                      });
                    }
                  }
                });

                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // 固定的搜索和筛选区域（可拖拽）
                      GestureDetector(
                        onVerticalDragUpdate: (details) {
                          // 拖拽时实时更新sheet大小
                          _sheetController.jumpTo(
                            (_sheetController.size -
                                    details.primaryDelta! /
                                        MediaQuery.of(context).size.height)
                                .clamp(0.2, 0.9),
                          );
                        },
                        onVerticalDragEnd: (details) {
                          // 根据滑动速度判断方向
                          final velocity = details.primaryVelocity ?? 0;
                          final currentSize = _sheetController.size;
                          const snapSizes = [0.2, 0.5, 0.9];

                          double targetSnap;

                          if (velocity.abs() > 500) {
                            if (velocity < 0) {
                              targetSnap = snapSizes.lastWhere(
                                (snap) => snap > currentSize,
                                orElse: () => snapSizes.last,
                              );
                            } else {
                              targetSnap = snapSizes.lastWhere(
                                (snap) => snap < currentSize,
                                orElse: () => snapSizes.first,
                              );
                            }
                          } else {
                            targetSnap = snapSizes[0];
                            double minDistance = (currentSize - snapSizes[0])
                                .abs();

                            for (var snapSize in snapSizes) {
                              final distance = (currentSize - snapSize).abs();
                              if (distance < minDistance) {
                                minDistance = distance;
                                targetSnap = snapSize;
                              }
                            }
                          }

                          _sheetController.animateTo(
                            targetSnap,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut,
                          );
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              // 拖拽指示器
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                width: 40,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),

                              // 搜索框
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    // 点击搜索框时直接跳转到所有机厅页面
                                    Get.toNamed(AppRoutes.allShops);
                                  },
                                  child: AbsorbPointer(
                                    child: TextField(
                                      controller: _searchController,
                                      focusNode: _searchFocusNode,
                                      decoration: InputDecoration(
                                        hintText: '搜索机厅...',
                                        prefixIcon: const Icon(Icons.search),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Theme.of(
                                          context,
                                        ).colorScheme.surfaceContainerHighest,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 12,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),

                              // 快捷筛选
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: QuickFilters(
                                  onFilterSelected: _onFilterSelected,
                                ),
                              ),

                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),

                      // 机厅列表 - 使用Expanded包裹以占据剩余空间
                      Expanded(
                        child: CustomScrollView(
                          controller: scrollController,
                          slivers: [
                            SliverPadding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              sliver: _buildShopListSliver(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopListSliver() {
    if (_isLoadingShops) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return SliverFillRemaining(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text('加载失败', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    _error!,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(onPressed: _loadShops, child: const Text('重试')),
              ],
            ),
          ),
        ),
      );
    }

    if (_filteredShops.isEmpty) {
      return const SliverFillRemaining(child: Center(child: Text('暂无店铺数据')));
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              '附近的机厅 (${_filteredShops.length})',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          );
        }
        return ShopCard(
          shop: _filteredShops[index - 1],
          onTap: () {
            // 点击卡片时移动相机并显示浮动卡片
            final shop = _filteredShops[index - 1];
            setState(() {
              _selectedShop = shop;
            });
            if (_mapController != null) {
              final target = LatLng(
                shop.location.latitude,
                shop.location.longitude,
              );
              _mapController!.moveCamera(
                amap.CameraUpdate.newLatLngZoom(target, 17),
              );
              // 收起sheet以便查看地图
              _sheetController.animateTo(
                0.2,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          },
          onNavigate: () {
            // TODO: 打开导航
          },
        );
      }, childCount: _filteredShops.length + 1),
    );
  }

  Widget _buildFloatingShopCard(Shop shop) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shop.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        shop.address.fullAddress,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.6),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _selectedShop = null;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _openMapNavigation(shop),
                    icon: const Icon(Icons.navigation, size: 18),
                    label: const Text('打开地图导航'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Get.toNamed(AppRoutes.shopDetail, arguments: shop);
                    },
                    icon: const Icon(Icons.info_outline, size: 18),
                    label: const Text('查看详情'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openMapNavigation(Shop shop) async {
    try {
      final availableMaps = await MapLauncher.installedMaps;

      if (availableMaps.isEmpty) {
        Get.snackbar('提示', '未找到可用的地图应用');
        return;
      }

      final coords = Coords(shop.location.latitude, shop.location.longitude);
      final title = shop.name;

      // 如果只有一个地图应用，直接打开
      if (availableMaps.length == 1) {
        await availableMaps.first.showMarker(coords: coords, title: title);
        return;
      }

      // 多个地图应用时显示选择对话框
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      '选择地图应用',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...availableMaps.map((map) {
                    return ListTile(
                      leading: Icon(Icons.map),
                      title: Text(map.mapName),
                      onTap: () {
                        Navigator.pop(context);
                        map.showMarker(coords: coords, title: title);
                      },
                    );
                  }),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      Get.snackbar('错误', '打开地图失败: $e');
    }
  }

  void _showRadiusDialog() {
    final radiusOptions = [1.0, 3.0, 5.0, 10.0, 20.0, 50.0];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '选择探索半径',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...radiusOptions.map((radius) {
                final isSelected = _searchRadius == radius;
                return ListTile(
                  leading: Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                  title: Text(
                    '${radius.toStringAsFixed(radius == radius.toInt() ? 0 : 1)} km',
                  ),
                  selected: isSelected,
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _searchRadius = radius;
                    });
                    _loadShops();
                  },
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
