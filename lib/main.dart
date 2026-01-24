import 'package:amap_map/amap_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fullscreen/flutter_fullscreen.dart';
import 'package:get/get.dart';
import 'package:rank_hub/routes/app_pages.dart';
import 'package:rank_hub/routes/app_routes.dart';
import 'package:rank_hub/controllers/theme_controller.dart';
import 'package:rank_hub/services/log_service.dart';
import 'package:rank_hub/services/queue_status_manager.dart';
import 'package:rank_hub/services/live_activity_service.dart';
import 'package:x_amap_base/x_amap_base.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化日志服务
  final logService = LogService.instance;
  logService.initialize();

  // 初始化 Live Activities
  await LiveActivityService.instance.init();

  // 初始化排队状态管理器
  Get.put(QueueStatusManager());

  await FullScreen.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());

    AMapInitializer.updatePrivacyAgree(
      AMapPrivacyStatement(hasContains: true, hasShow: true, hasAgree: true),
    );

    AMapInitializer.init(
      context,
      apiKey: AMapApiKey(
        iosKey: '808f8cff67cf6e0af5d1718a9d3b6a6b',
        androidKey: '9d203d41e9a4e6f41f16845a56ccec81',
      ),
    );

    return Obx(
      () => GetMaterialApp(
        title: 'RankHub',
        theme: themeController.getLightTheme(),
        darkTheme: themeController.getDarkTheme(),
        themeMode: themeController.themeMode.value,
        initialRoute: AppRoutes.main,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
