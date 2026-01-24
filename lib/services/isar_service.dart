import 'package:rank_hub/services/base_isar_service.dart';
import 'package:rank_hub/modules/lxns/services/maimai_isar_service.dart';
import 'package:rank_hub/services/account_isar_service.dart';

/// Isar 数据库服务统一入口
/// 提供对各游戏数据库服务的访问
class IsarService {
  static IsarService? _instance;

  IsarService._();

  /// 获取单例实例
  static IsarService get instance {
    _instance ??= IsarService._();
    return _instance!;
  }

  /// Maimai 游戏数据库服务
  ///
  /// 使用示例:
  /// ```dart
  /// final songs = await IsarService.instance.maimai.getAllSongs();
  /// ```
  MaimaiIsarService get maimai => MaimaiIsarService.instance;

  /// 账号管理数据库服务
  ///
  /// 使用示例:
  /// ```dart
  /// final accounts = await IsarService.instance.account.getAllAccounts();
  /// ```
  AccountIsarService get account => AccountIsarService.instance;

  // 添加其他游戏的数据库服务
  // ChunithmIsarService get chunithm => ChunithmIsarService.instance;
  // OngekiIsarService get ongeki => OngekiIsarService.instance;

  /// 关闭所有数据库
  Future<void> closeAll() async {
    await BaseIsarService.closeAll();
  }
}
