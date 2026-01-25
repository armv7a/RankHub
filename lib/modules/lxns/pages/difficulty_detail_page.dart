import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rank_hub/models/maimai/enums/level_index.dart';
import 'package:rank_hub/controllers/account_controller.dart';
import 'package:rank_hub/services/credential_provider.dart';
import 'package:rank_hub/modules/lxns/maimai_lxns.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../widgets/note_table.dart';
import '../widgets/score_history_chart.dart';
import '../widgets/dx_rating_table.dart';
import '../widgets/current_score_card.dart';
import '../widgets/tolerance_calculator.dart';
import 'package:rank_hub/models/maimai/score.dart';

/// 谱面详情页面
class DifficultyDetailPage extends StatefulWidget {
  final dynamic difficulty; // SongDifficulty or SongDifficultyUtage
  final String songName;
  final int songId;

  const DifficultyDetailPage({
    super.key,
    required this.difficulty,
    required this.songName,
    required this.songId,
  });

  @override
  State<DifficultyDetailPage> createState() => _DifficultyDetailPageState();
}

class _DifficultyDetailPageState extends State<DifficultyDetailPage>
    with SingleTickerProviderStateMixin {
  int _calculateMode = 0; // 0: 绝对值, 1: CRITICAL差值, 2: PERFECT差值
  final ChromeSafariBrowser browser = ChromeSafariBrowser();
  List<Map<String, dynamic>>? _historyData;
  bool _isLoadingHistory = false;
  String? _historyError;
  Score? _currentScore;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    _loadCurrentScore();
    _loadScoreHistory();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// 加载当前成绩
  Future<void> _loadCurrentScore() async {
    try {
      final score = await MaimaiIsarService.instance
          .getScoreBySongIdAndDifficulty(
            songId: widget.songId,
            levelIndex: widget.difficulty.difficulty,
            type: widget.difficulty.type,
          );

      if (mounted) {
        setState(() {
          _currentScore = score;
        });
      }
    } catch (e) {
      print('加载当前成绩失败: $e');
    }
  }

  Future<void> _loadScoreHistory() async {
    final accountController = Get.find<AccountController>();
    final currentAccount = accountController.currentAccount;

    if (currentAccount == null) {
      return;
    }

    setState(() {
      _isLoadingHistory = true;
      _historyError = null;
    });

    try {
      final credential = await LxnsCredentialProvider().getCredential(
        currentAccount,
      );

      if (credential.accessToken == null) {
        return;
      }

      final history = await MaimaiApiService.instance.getScoreHistory(
        accessToken: credential.accessToken!,
        songId: widget.songId,
        levelIndex: widget.difficulty.difficulty.value,
        songType: widget.difficulty.type.value,
      );

      if (mounted) {
        setState(() {
          // 检查返回的数据是否为空
          if (history.isEmpty) {
            _historyData = null;
            _historyError = '游玩记录不足，无法生成图表';
          } else {
            _historyData = history.reversed.toList(); // 反转，最早的在前
          }
          _isLoadingHistory = false;
        });
      }
    } on CredentialExpiredException {
      if (mounted) {
        setState(() {
          _historyError = '凭据已失效，请在账号管理页面重新登录';
          _isLoadingHistory = false;
        });
      }
      Get.snackbar(
        '凭据已失效',
        '请在账号管理页面重新登录',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _historyError = e.toString();
          _isLoadingHistory = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final difficultyColor = _getDifficultyColor();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://assets2.lxns.net/maimai/jacket/${widget.songId}.png',
                width: 32,
                height: 32,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 32,
                    height: 32,
                    color: colorScheme.surfaceContainerHighest,
                    child: Icon(
                      Icons.music_note,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.songName,
                    style: const TextStyle(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${widget.difficulty.difficulty.label} ${widget.difficulty.level}',
                    style: TextStyle(fontSize: 14, color: difficultyColor),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '谱面信息'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 谱面信息页
          widget.difficulty.notes == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 64,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '暂无物量数据',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 基本信息卡片
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '谱面信息',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                _buildInfoRow(
                                  '难度',
                                  widget.difficulty.difficulty.label,
                                ),
                                const Divider(height: 24),
                                _buildInfoRow(
                                  '定数',
                                  widget.difficulty.levelValue.toStringAsFixed(
                                    1,
                                  ),
                                ),
                                const Divider(height: 24),
                                _buildInfoRow(
                                  '谱师',
                                  widget.difficulty.noteDesigner,
                                ),
                                const Divider(height: 24),
                                _buildInfoRow(
                                  '类型',
                                  widget.difficulty.type.value == 'dx'
                                      ? 'DX'
                                      : '标准',
                                ),
                                const Divider(height: 24),
                                _buildInfoRow(
                                  '总物量',
                                  widget.difficulty.notes!.total.toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // 搜索谱面确认按钮
                        Center(
                          child: TextButton(
                            onPressed: () async {
                              final keyword =
                                  '${widget.songName} ${widget.difficulty.difficulty.label} 谱面确认';
                              final url =
                                  'bilibili://search?keyword=$keyword'; // 替换为目标应用的 URL Scheme
                              final Uri uri = Uri.parse(url);

                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri);
                              } else {
                                await browser.open(
                                  url: WebUri(
                                    "https://search.bilibili.com/video?keyword=$keyword",
                                  ),
                                  settings: ChromeSafariBrowserSettings(
                                    presentationStyle:
                                        ModalPresentationStyle.FORM_SHEET,
                                    shareState:
                                        CustomTabsShareState.SHARE_STATE_OFF,
                                    barCollapsingEnabled: true,
                                  ),
                                );
                              }
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("在 哔哩哔哩 中搜索谱面确认"),
                                SizedBox(width: 8),
                                Icon(Icons.open_in_new),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // 当前成绩卡片
                        if (_currentScore != null)
                          CurrentScoreCard(
                            score: _currentScore!,
                            maxDxScore: widget.difficulty.notes!.total * 3,
                            backgroundColor: _getCurrentScoreCardColor(),
                          ),
                        if (_currentScore != null) const SizedBox(height: 16),
                        // 历史成绩图表
                        if (_historyData != null ||
                            _isLoadingHistory ||
                            _historyError != null)
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '历史成绩',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      const Spacer(),
                                      if (_historyData != null)
                                        Text(
                                          '共 ${_historyData!.length} 次游玩',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  if (_isLoadingHistory)
                                    const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(32),
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  else if (_historyError != null)
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(32),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.error_outline,
                                              size: 48,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.error,
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              '加载失败: $_historyError',
                                              style: TextStyle(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.error,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  else if (_historyData != null &&
                                      _historyData!.isNotEmpty)
                                    SizedBox(
                                      height: 300,
                                      child: ScoreHistoryChart(
                                        historyData: _historyData!,
                                      ),
                                    )
                                  else
                                    const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(32),
                                        child: Text('暂无历史成绩数据'),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        const SizedBox(height: 16),
                        // 物量详情表（包含计算模式选择）
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '物量详情表',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 12),
                                // 计算模式选择
                                SegmentedButton<int>(
                                  segments: const [
                                    ButtonSegment(
                                      value: 0,
                                      label: Text('绝对值'),
                                      icon: Icon(Icons.calculate, size: 16),
                                    ),
                                    ButtonSegment(
                                      value: 1,
                                      label: Text('CRITICAL差值'),
                                      icon: Icon(Icons.stars, size: 16),
                                    ),
                                    ButtonSegment(
                                      value: 2,
                                      label: Text('PERFECT差值'),
                                      icon: Icon(Icons.star, size: 16),
                                    ),
                                  ],
                                  selected: {_calculateMode},
                                  onSelectionChanged: (Set<int> newSelection) {
                                    setState(() {
                                      _calculateMode = newSelection.first;
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  height: 380,
                                  child: NoteTable(
                                    notes: widget.difficulty.notes!,
                                    calculateMode: _calculateMode,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // 容错计算器
                        ToleranceCalculator(notes: widget.difficulty.notes!),
                        const SizedBox(height: 16),
                        // DX Rating 分表
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'DX Rating 分数表',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(width: 8),
                                    if (_currentScore != null)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primaryContainer,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          '${_currentScore!.achievements.toStringAsFixed(4)}% → ${_currentScore!.dxRating.toInt()}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onPrimaryContainer,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                DxRatingTable(
                                  levelValue: widget.difficulty.levelValue,
                                  currentAchievement:
                                      _currentScore?.achievements,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Color _getDifficultyColor() {
    switch (widget.difficulty.difficulty) {
      case LevelIndex.basic:
        return Colors.green;
      case LevelIndex.advanced:
        return Colors.yellow.shade700;
      case LevelIndex.expert:
        return Colors.red;
      case LevelIndex.master:
        return Colors.purple;
      case LevelIndex.reMaster:
        return Colors.purple.shade200;
      default:
        return Colors.blue;
    }
  }

  Color _getCurrentScoreCardColor() {
    final type = widget.difficulty.type;
    if (type is SongType && type == SongType.utage) {
      return const Color.fromARGB(255, 255, 111, 253);
    }

    switch (widget.difficulty.difficulty) {
      case LevelIndex.basic:
        return const Color.fromARGB(255, 107, 223, 95);
      case LevelIndex.advanced:
        return const Color.fromARGB(255, 254, 209, 74);
      case LevelIndex.expert:
        return const Color.fromARGB(255, 255, 129, 141);
      case LevelIndex.master:
        return const Color.fromARGB(255, 130, 100, 200);
      case LevelIndex.reMaster:
        return const Color.fromARGB(255, 218, 90, 255);
    }

    return const Color.fromARGB(255, 130, 100, 200);
  }
}
