import 'package:isar_community/isar.dart';

part 'account.g.dart';

/// 账号平台类型
enum Platform {
  /// 水鱼查分器
  divingFish,

  /// Lxns (落雪咖啡屋)
  lxns,

  /// 开发者鱼
  developerFish,

  /// 其他自定义平台
  custom,
}

/// 凭据类型
enum CredentialType {
  /// API Key
  apiKey,

  /// OAuth2
  oauth2,

  /// 用户名密码
  userPassword,

  /// 自定义
  custom,
}

/// 账号信息（包含凭据）
@collection
class Account {
  Account({
    this.id = Isar.autoIncrement,
    required this.platform,
    required this.externalId,
    required this.credentialType,
    this.displayName,
    this.avatarUrl,
    this.bindTime,
    this.lastSyncTime,
    this.isActive = true,
    this.metadata,
    this.apiKey,
    this.accessToken,
    this.refreshToken,
    this.tokenExpiry,
    this.username,
    this.password,
    this.additionalData,
    this.credentialCreatedAt,
    this.credentialUpdatedAt,
  });

  /// Isar 自增 ID
  Id id;

  /// 平台类型
  @Enumerated(EnumType.name)
  late Platform platform;

  /// 平台上的唯一标识符 (如用户名、好友码等)
  @Index(composite: [CompositeIndex('platform')], unique: true)
  late String externalId;

  /// 凭据类型
  @Enumerated(EnumType.name)
  late CredentialType credentialType;

  /// 显示名称
  String? displayName;

  /// 头像 URL
  String? avatarUrl;

  /// 绑定时间
  DateTime? bindTime;

  /// 最后同步时间
  DateTime? lastSyncTime;

  /// 是否激活状态
  late bool isActive;

  /// 平台特定的元数据 (JSON 字符串)
  String? metadata;

  // ==================== 凭据字段 ====================

  // ===== API Key 类型字段 =====
  /// API Key
  String? apiKey;

  // ===== OAuth2 类型字段 =====
  /// 访问令牌
  String? accessToken;

  /// 刷新令牌
  String? refreshToken;

  /// 令牌过期时间
  DateTime? tokenExpiry;

  // ===== 用户名密码类型字段 =====
  /// 用户名
  String? username;

  /// 密码 (应加密存储)
  String? password;

  // ===== 通用字段 =====
  /// 额外数据 (JSON 字符串,用于存储平台特定的其他凭据信息)
  String? additionalData;

  /// 凭据创建时间
  DateTime? credentialCreatedAt;

  /// 凭据更新时间
  DateTime? credentialUpdatedAt;

  // ==================== 凭据辅助方法 ====================

  /// 检查令牌是否过期
  bool get isTokenExpired {
    if (tokenExpiry == null) return false;
    return DateTime.now().isAfter(tokenExpiry!);
  }

  /// 检查令牌是否即将过期 (5分钟内)
  bool get isTokenExpiringSoon {
    if (tokenExpiry == null) return false;
    final fiveMinutesLater = DateTime.now().add(const Duration(minutes: 5));
    return fiveMinutesLater.isAfter(tokenExpiry!);
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] as int? ?? Isar.autoIncrement,
      platform: Platform.values.firstWhere(
        (e) => e.name == json['platform'],
        orElse: () => Platform.custom,
      ),
      externalId: json['external_id'] as String,
      credentialType: CredentialType.values.firstWhere(
        (e) => e.name == json['credential_type'],
        orElse: () => CredentialType.custom,
      ),
      displayName: json['display_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      bindTime: json['bind_time'] != null
          ? DateTime.parse(json['bind_time'] as String)
          : null,
      lastSyncTime: json['last_sync_time'] != null
          ? DateTime.parse(json['last_sync_time'] as String)
          : null,
      isActive: json['is_active'] as bool? ?? true,
      metadata: json['metadata'] as String?,
      // 凭据字段
      apiKey: json['api_key'] as String?,
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      tokenExpiry: json['token_expiry'] != null
          ? DateTime.parse(json['token_expiry'] as String)
          : null,
      username: json['username'] as String?,
      password: json['password'] as String?,
      additionalData: json['additional_data'] as String?,
      credentialCreatedAt: json['credential_created_at'] != null
          ? DateTime.parse(json['credential_created_at'] as String)
          : null,
      credentialUpdatedAt: json['credential_updated_at'] != null
          ? DateTime.parse(json['credential_updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'platform': platform.name,
      'external_id': externalId,
      'credential_type': credentialType.name,
      'display_name': displayName,
      'avatar_url': avatarUrl,
      'bind_time': bindTime?.toIso8601String(),
      'last_sync_time': lastSyncTime?.toIso8601String(),
      'is_active': isActive,
      'metadata': metadata,
      // 凭据字段
      'api_key': apiKey,
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'token_expiry': tokenExpiry?.toIso8601String(),
      'username': username,
      'password': password,
      'additional_data': additionalData,
      'credential_created_at': credentialCreatedAt?.toIso8601String(),
      'credential_updated_at': credentialUpdatedAt?.toIso8601String(),
    };
  }
}
