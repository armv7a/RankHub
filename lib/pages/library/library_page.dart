import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rank_hub/core/core_context.dart';
import 'package:rank_hub/core/game.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appContext = ref.watch(appContextProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('曲目'),
        titleSpacing: 24,
        centerTitle: false,
      ),
      body: _buildBody(context, ref, appContext),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    AppContext? appContext,
  ) {
    if (appContext == null) {
      return _buildEmptyView(context);
    }

    return _buildGameContent(context, ref, appContext.game);
  }

  /// 构建游戏内容
  Widget _buildGameContent(BuildContext context, WidgetRef ref, Game game) {
    final descriptor = game.descriptor;
    final libraryPages = descriptor.libraryPages;

    if (libraryPages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              '该游戏暂无资料库内容',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    // 如果只有一个页面,直接显示
    if (libraryPages.length == 1) {
      return libraryPages.first.builder(context);
    }

    // 多个页面时使用 TabBar
    return DefaultTabController(
      length: libraryPages.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabs: libraryPages
                .map((page) => Tab(text: page.title, icon: Icon(page.icon)))
                .toList(),
          ),
          Expanded(
            child: TabBarView(
              children: libraryPages
                  .map((page) => page.builder(context))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建空视图
  Widget _buildEmptyView(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.library_books_outlined,
            size: 80,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 24),
          Text(
            '请先添加账号',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '添加账号后即可查看曲目',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
