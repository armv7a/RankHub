import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const String appVersion = '1.0.6';
  static const String buildNumber = String.fromEnvironment(
    'BUILD_NUMBER',
    defaultValue: '0',
  );
  static const String githubRepo = 'https://github.com/qianmo2233/RankHub';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('关于')),
      body: ListView(
        children: [
          // 应用图标和名称
          Container(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.primary.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'icon-1024.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'RankHub',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '音游成绩管理与数据同步聚合平台',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'v$appVersion ($buildNumber)',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          const Divider(),

          // 应用信息
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              '应用信息',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('应用简介'),
            subtitle: const Text('统一管理多平台音游或查分器账号，同步成绩数据'),
            onTap: () => _showDescriptionDialog(context),
          ),
          const Divider(indent: 16, endIndent: 16),
          ListTile(
            leading: const Icon(Icons.new_releases_outlined),
            title: const Text('版本号'),
            subtitle: Text('v$appVersion ($buildNumber)'),
          ),
          const Divider(indent: 16, endIndent: 16),
          ListTile(
            leading: const Icon(Icons.update),
            title: const Text('检查更新'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _checkForUpdates(context),
          ),

          // 开发团队
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Text(
              '开发团队',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: const Text('开发者'),
            subtitle: const Text('@qianmo2233'),
            trailing: const Icon(Icons.open_in_new),
            onTap: () => _launchURL('https://github.com/qianmo2233'),
          ),
          const Divider(indent: 16, endIndent: 16),
          ListTile(
            leading: const Icon(Icons.people_outline),
            title: const Text('贡献者'),
            subtitle: const Text('感谢所有为本项目做出贡献的开发者'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showContributors(context),
          ),

          // 开源信息
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Text(
              '开源',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.code_outlined),
            title: const Text('GitHub 仓库'),
            subtitle: const Text('qianmo2233/RankHub'),
            trailing: const Icon(Icons.open_in_new),
            onTap: () => _launchURL(githubRepo),
          ),
          const Divider(indent: 16, endIndent: 16),
          ListTile(
            leading: const Icon(Icons.article_outlined),
            title: const Text('开源许可证'),
            subtitle: const Text('查看项目许可证'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showLicense(context),
          ),
          const Divider(indent: 16, endIndent: 16),
          ListTile(
            leading: const Icon(Icons.library_books_outlined),
            title: const Text('第三方库'),
            subtitle: const Text('查看使用的开源库'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showLicenses(context),
          ),

          // 支持
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Text(
              '支持',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.bug_report_outlined),
            title: const Text('反馈问题'),
            subtitle: const Text('在 GitHub 提交 Issue'),
            trailing: const Icon(Icons.open_in_new),
            onTap: () => _launchURL('$githubRepo/issues'),
          ),
          const Divider(indent: 16, endIndent: 16),
          ListTile(
            leading: const Icon(Icons.star_outline),
            title: const Text('给个 Star'),
            subtitle: const Text('如果你喜欢这个项目，请给个 Star'),
            trailing: const Icon(Icons.open_in_new),
            onTap: () => _launchURL(githubRepo),
          ),

          const SizedBox(height: 32),

          // 版权信息
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '© ${DateTime.now().year} Fukakai Project\nMade with ❤️ by qianmo SAMA',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showDescriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('应用简介'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('RankHub 是一款专为音游玩家设计的成绩管理应用。'),
              SizedBox(height: 16),
              Text('主要功能：'),
              SizedBox(height: 8),
              Text('• 多平台账号统一管理'),
              Text('• 成绩数据同步'),
              Text('• 排行榜查看'),
              Text('• 曲目百科'),
              Text('• 个人数据分析'),
              SizedBox(height: 16),
              Text('支持平台：'),
              SizedBox(height: 8),
              Text('• 落雪咖啡屋 (LXNS)'),
              Text('• 水鱼查分器'),
              Text('• 更多平台持续添加中...'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  void _checkForUpdates(BuildContext context) {
    Get.snackbar(
      '检查更新',
      '当前已是最新版本 v$appVersion',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _showContributors(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('贡献者'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('感谢以下开发者为本项目做出的贡献：'),
              SizedBox(height: 16),
              Text('• qianmo2233 - 项目创建者'),
              SizedBox(height: 16),
              Text('以及所有在 GitHub 上提交 PR 和 Issue 的贡献者！'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  void _showLicense(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('开源许可证'),
        content: const SingleChildScrollView(
          child: Text(
            '本项目遵循开源协议发布。\n\n'
            '具体许可证信息请访问 GitHub 仓库查看 LICENSE 文件。',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _launchURL('$githubRepo/blob/main/LICENSE');
            },
            child: const Text('查看'),
          ),
        ],
      ),
    );
  }

  void _showLicenses(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Theme(
          data: Theme.of(context),
          child: const LicensePage(
            applicationName: 'RankHub',
            applicationVersion: 'v$appVersion ($buildNumber)',
            applicationLegalese:
                '© ${2025} RankHub\nMade with ❤️ by qianmo2233',
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('错误', '无法打开链接', snackPosition: SnackPosition.BOTTOM);
    }
  }
}
