import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'maimai_lxns_controller.dart';
import 'widgets/song_list_view.dart';

/// 曲目列表 Tab
class SongsTab extends StatelessWidget {
  const SongsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MaimaiLxnsController>();

    return Obx(() {
      // 加载状态
      if (controller.loadStatus == DataLoadStatus.loadingFromDb ||
          controller.loadStatus == DataLoadStatus.loadingFromApi) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                controller.loadStatus == DataLoadStatus.loadingFromDb
                    ? '正在从数据库加载...'
                    : '正在从 API 加载...',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      }

      // 错误状态
      if (controller.loadStatus == DataLoadStatus.error) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                controller.errorMessage,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => controller.loadSongs(),
                icon: const Icon(Icons.refresh),
                label: const Text('重试'),
              ),
            ],
          ),
        );
      }

      // 空数据
      if (controller.songs.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.music_off,
                size: 64,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text('暂无曲目数据', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(
                '请先同步数据',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        );
      }

      // 显示数据
      return const SongListView();
    });
  }
}
