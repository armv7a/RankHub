import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rank_hub/controllers/main_controller.dart';
import 'package:rank_hub/pages/wiki.dart';
import 'package:rank_hub/pages/rank.dart';
import 'package:rank_hub/pages/toolbox.dart';
import 'package:rank_hub/pages/nearcade.dart';
import 'package:rank_hub/pages/mine.dart';
import 'dart:ui';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Obx(
        () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.995, end: 1.0).animate(animation),
                child: child,
              ),
            );
          },
          child: IndexedStack(
            key: ValueKey<int>(controller.currentIndex.value),
            index: controller.currentIndex.value,
            children: const [
              WikiPage(),
              RankPage(),
              ToolboxPage(),
              NearcadePage(),
              MinePage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: NavigationBar(
              selectedIndex: controller.currentIndex.value,
              onDestinationSelected: controller.changeTabIndex,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surface.withOpacity(0.8),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.book_outlined),
                  selectedIcon: Icon(Icons.book),
                  label: '资料库',
                ),
                NavigationDestination(
                  icon: Icon(Icons.query_stats_outlined),
                  selectedIcon: Icon(Icons.query_stats),
                  label: '成绩',
                ),
                NavigationDestination(
                  icon: Icon(Icons.construction_outlined),
                  selectedIcon: Icon(Icons.construction),
                  label: '工具箱',
                ),
                NavigationDestination(
                  icon: Icon(Icons.gamepad_outlined),
                  selectedIcon: Icon(Icons.gamepad),
                  label: '机厅',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: '我的',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
