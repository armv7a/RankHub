import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart' hide Response;
import 'package:rank_hub/models/account/account.dart';
import 'package:rank_hub/services/platform_login_handler.dart';
import 'package:rank_hub/utils/pkce_helper.dart';
import 'lxns_api_response.dart';

/// 落雪咖啡屋平台登录处理器
/// 使用 OAuth2 + PKCE 授权流程
class LxnsLoginHandler extends PlatformLoginHandler {
  // OAuth2 配置
  static const String baseUrl = 'https://maimai.lxns.net';
  static const String iconUrl = 'https://maimai.lxns.net/favicon.webp';
  static const String backgroundUrl =
      'https://maimai.lxns.net/logo_background.webp';
  static const String foregroundUrl =
      'https://maimai.lxns.net/logo_foreground.webp';
  static const String clientId = 'd7a8e3dc-0e08-43b1-ac08-7e4b2b4574bd';
  static const String redirectUri = 'https://rankhub.kamitsubaki.city/callback';
  static const String scope =
      'read_user_profile read_player read_user_token write_player';

  // 手动输入授权码配置（使用 urn:ietf:wg:oauth:2.0:oob）
  static const String manualClientId = '2f8e94e4-1faf-4213-bfbc-0aaf55e71a86';
  static const String manualRedirectUri = 'urn:ietf:wg:oauth:2.0:oob';

  final Dio _dio = Dio();

  @override
  Platform get platform => Platform.lxns;

  @override
  String get platformName => '落雪咖啡屋';

  @override
  IconData get platformIcon => Icons.coffee;

  @override
  String get platformIconUrl => iconUrl;

  @override
  String get platformDescription => '舞萌DX/中二节奏查分器 - 使用 OAuth2 授权登录';

  @override
  Future<PlatformLoginResult?> showLoginPage(BuildContext context) async {
    return await Navigator.push<PlatformLoginResult>(
      context,
      MaterialPageRoute(
        builder: (context) => const _LxnsOAuth2LoginPage(),
        fullscreenDialog: true,
      ),
    );
  }

  /// 执行 OAuth2 登录流程
  Future<PlatformLoginResult?> performOAuth2Login() async {
    try {
      // 生成 PKCE 参数
      final pkcePair = PkceHelper.generatePkcePair();
      final codeVerifier = pkcePair['code_verifier']!;
      final codeChallenge = pkcePair['code_challenge']!;

      // 生成随机 state 用于防止 CSRF 攻击
      final state = DateTime.now().millisecondsSinceEpoch.toString();

      // 构建授权 URL
      final authUrl =
          '$baseUrl/oauth/authorize?'
          'response_type=code&'
          'client_id=$clientId&'
          'redirect_uri=${Uri.encodeComponent(redirectUri)}&'
          'scope=${Uri.encodeComponent(scope)}&'
          'code_challenge=$codeChallenge&'
          'code_challenge_method=S256&'
          'state=$state';

      print('🔐 开始 OAuth2 授权...');
      print('📤 授权 URL: $authUrl');
      print('📤 Redirect URI: $redirectUri');

      // 使用应用内 WebView 打开授权页面
      final result = await _showOAuth2WebView(authUrl);
      if (result == null || result.isEmpty) {
        print('❌ 未收到回调 URL');
        return null;
      }

      print('📥 收到回调: $result');

      // 解析回调 URL
      final uri = Uri.parse(result);
      final code = uri.queryParameters['code'];
      final returnedState = uri.queryParameters['state'];

      if (code == null) {
        print('❌ 未收到授权码');
        return null;
      }

      // 验证 state
      if (returnedState != state) {
        print('❌ State 验证失败');
        return null;
      }

      print('✅ 授权码获取成功: $code');

      // 使用授权码交换 token
      final tokenData = await exchangeCodeForToken(code, codeVerifier);
      if (tokenData == null) {
        print('❌ 交换 token 失败');
        return null;
      }

      // 获取账号信息
      final accountInfo = await fetchAccountInfo(tokenData);
      if (accountInfo == null) {
        print('❌ 获取账号信息失败');
        return null;
      }

      print('✅ 登录成功: ${accountInfo.displayName}');

      return PlatformLoginResult(
        externalId: accountInfo.externalId,
        credentialData: tokenData,
        displayName: accountInfo.displayName,
        avatarUrl: accountInfo.avatarUrl,
        metadata: accountInfo.metadata,
      );
    } catch (e) {
      print('❌ OAuth2 登录失败: $e');
      return null;
    }
  }

  /// 执行手动授权码登录流程（使用 InAppWebView）
  Future<PlatformLoginResult?> performManualOAuth2Login() async {
    try {
      // 生成 PKCE 参数
      final pkcePair = PkceHelper.generatePkcePair();
      final codeVerifier = pkcePair['code_verifier']!;
      final codeChallenge = pkcePair['code_challenge']!;

      // 生成随机 state 用于防止 CSRF 攻击
      final state = DateTime.now().millisecondsSinceEpoch.toString();

      // 构建授权 URL（使用手动配置）
      final authUrl =
          '$baseUrl/oauth/authorize?'
          'response_type=code&'
          'client_id=$manualClientId&'
          'redirect_uri=${Uri.encodeComponent(manualRedirectUri)}&'
          'scope=${Uri.encodeComponent(scope)}&'
          'code_challenge=$codeChallenge&'
          'code_challenge_method=S256&'
          'state=$state';

      print('🔐 开始手动授权流程...');
      print('📤 授权 URL: $authUrl');
      print('📤 Redirect URI: $manualRedirectUri');

      // 此方法返回用户输入的授权码
      final code = await _showManualAuthPage(authUrl);

      if (code == null || code.isEmpty) {
        print('❌ 未收到授权码');
        return null;
      }

      print('✅ 授权码获取成功: $code');

      // 使用授权码交换 token（使用手动配置）
      final tokenData = await exchangeCodeForTokenManual(code, codeVerifier);
      if (tokenData == null) {
        print('❌ 交换 token 失败');
        return null;
      }

      // 获取账号信息
      final accountInfo = await fetchAccountInfo(tokenData);
      if (accountInfo == null) {
        print('❌ 获取账号信息失败');
        return null;
      }

      print('✅ 登录成功: ${accountInfo.displayName}');

      return PlatformLoginResult(
        externalId: accountInfo.externalId,
        credentialData: tokenData,
        displayName: accountInfo.displayName,
        avatarUrl: accountInfo.avatarUrl,
        metadata: accountInfo.metadata,
      );
    } catch (e) {
      print('❌ 手动授权登录失败: $e');
      return null;
    }
  }

  /// 显示手动授权页面（使用 InAppWebView）
  Future<String?> _showManualAuthPage(String authUrl) async {
    // 导航到手动授权页面
    final BuildContext? context = Get.context;
    if (context == null) return null;

    return await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => _ManualAuthPage(authUrl: authUrl),
        fullscreenDialog: true,
      ),
    );
  }

  /// 显示 OAuth2 授权页面（应用内 WebView）
  Future<String?> _showOAuth2WebView(String authUrl) async {
    final BuildContext? context = Get.context;
    if (context == null) return null;

    return await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder:
            (context) => _OAuth2WebViewPage(
              authUrl: authUrl,
              redirectUri: redirectUri,
            ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Future<bool> validateCredentials(Map<String, dynamic> credentialData) async {
    final accessToken = credentialData['access_token'] as String?;
    if (accessToken == null || accessToken.isEmpty) {
      return false;
    }

    // 验证 token 是否有效 - 使用 profile 接口
    try {
      final response = await _dio.get(
        '$baseUrl/api/v0/user/profile',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode == 200) {
        final apiResponse = LxnsApiResponse.fromJson(response.data);
        return apiResponse.success;
      }
      return false;
    } catch (e) {
      print('验证 token 失败: $e');
      return false;
    }
  }

  @override
  Future<PlatformAccountInfo?> fetchAccountInfo(
    Map<String, dynamic> credentialData,
  ) async {
    final accessToken = credentialData['access_token'] as String?;
    if (accessToken == null) {
      return null;
    }

    try {
      print('📤 获取用户信息...');
      final profileResponse = await _dio.get(
        '$baseUrl/api/v0/user/profile',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      print('📥 响应: ${profileResponse.data}');

      if (profileResponse.statusCode == 200) {
        final apiResponse = LxnsApiResponse<Map<String, dynamic>>.fromJson(
          profileResponse.data,
          dataParser: (data) => data as Map<String, dynamic>,
        );

        if (!apiResponse.success) {
          print('❌ API 返回失败: ${apiResponse.message}');
          return null;
        }

        final profileData = apiResponse.data!;
        final userId = profileData['id'];
        final userName = profileData['name'];
        final userEmail = profileData['email'];

        print('✅ 获取用户信息成功: $userName (ID: $userId)');

        return PlatformAccountInfo(
          externalId: userId.toString(),
          displayName: userName ?? 'lxns_user',
          avatarUrl: iconUrl,
          metadata: {'user_id': userId, 'email': userEmail},
        );
      }
    } catch (e) {
      print('❌ 获取账号信息失败: $e');
    }
    return null;
  }

  @override
  Future<Map<String, dynamic>?> refreshCredentials(
    Map<String, dynamic> oldCredentialData,
  ) async {
    final refreshToken = oldCredentialData['refresh_token'] as String?;
    if (refreshToken == null) {
      print('❌ 刷新 token 失败: refresh_token 为 null');
      return null;
    }

    print('🔄 开始刷新 token...');
    print('📤 请求 URL: $baseUrl/api/v0/oauth/token');
    print('📤 请求方法: POST');
    print('📤 Content-Type: ${Headers.jsonContentType}');
    print('📤 请求数据: {');
    print('     client_id: $clientId');
    print('     grant_type: refresh_token');
    print('     refresh_token: $refreshToken');
    print('   }');

    try {
      final response = await _dio.post(
        '$baseUrl/api/v0/oauth/token',
        data: {
          'client_id': clientId,
          'grant_type': 'refresh_token',
          'refresh_token': refreshToken,
          //'client_secret': 'gD93xzHD8XGrWNmjsyZ131REOd3nQxym',
        },
        options: Options(contentType: Headers.jsonContentType),
      );

      print('📥 响应状态码: ${response.statusCode}');
      print('📥 响应 Headers: ${response.headers}');
      print('📥 响应数据: ${response.data}');

      if (response.statusCode == 200) {
        final apiResponse = LxnsApiResponse<Map<String, dynamic>>.fromJson(
          response.data,
          dataParser: (data) => data as Map<String, dynamic>,
        );

        if (!apiResponse.success) {
          print('❌ API 返回失败: ${apiResponse.message}');
          return null;
        }

        final data = apiResponse.data!;
        final newTokenData = {
          'access_token': data['access_token'],
          'refresh_token': data['refresh_token'],
          'token_expiry': DateTime.now()
              .add(Duration(seconds: data['expires_in'] as int))
              .toIso8601String(),
        };
        print('✅ 刷新 token 成功');
        print(
          '   新 access_token: ${(data['access_token'] as String).substring(0, 10)}...',
        );
        print(
          '   新 refresh_token: ${(data['refresh_token'] as String).substring(0, 10)}...',
        );
        print('   过期时间: ${newTokenData['token_expiry']}');
        return newTokenData;
      }
    } on DioException catch (dioException) {
      print('❌ 刷新 token 失败 (DioException):');
      print('   错误类型: ${dioException.type}');
      print('   错误消息: ${dioException.message}');
      print('   响应状态码: ${dioException.response?.statusCode}');
      print('   响应数据: ${dioException.response?.data}');
      print('   响应 Headers: ${dioException.response?.headers}');
    } catch (e) {
      print('❌ 刷新 token 失败 (未知错误): $e');
      print('   错误类型: ${e.runtimeType}');
    }
    return null;
  }

  /// 使用授权码交换访问令牌
  Future<Map<String, dynamic>?> exchangeCodeForToken(
    String code,
    String codeVerifier,
  ) async {
    print('🔄 开始交换授权码...');
    print('📤 请求 URL: $baseUrl/api/v0/oauth/token');
    print('📤 授权码: $code');

    try {
      final response = await _dio.post(
        '$baseUrl/api/v0/oauth/token',
        data: {
          'client_id': clientId,
          'grant_type': 'authorization_code',
          'code': code,
          'redirect_uri': redirectUri,
          'code_verifier': codeVerifier,
        },
        options: Options(contentType: Headers.jsonContentType),
      );

      print('📥 响应状态码: ${response.statusCode}');
      print('📥 响应数据: ${response.data}');

      if (response.statusCode == 200) {
        final apiResponse = LxnsApiResponse<Map<String, dynamic>>.fromJson(
          response.data,
          dataParser: (data) => data as Map<String, dynamic>,
        );

        if (!apiResponse.success) {
          print('❌ API 返回失败: ${apiResponse.message}');
          return null;
        }

        final data = apiResponse.data!;
        final tokenData = {
          'access_token': data['access_token'],
          'refresh_token': data['refresh_token'],
          'token_expiry': DateTime.now()
              .add(Duration(seconds: data['expires_in'] as int))
              .toIso8601String(),
          'scope': data['scope'],
        };

        print('✅ 交换 token 成功');
        return tokenData;
      }
    } on DioException catch (dioException) {
      print('❌ 交换 token 失败 (DioException):');
      print('   错误类型: ${dioException.type}');
      print('   响应数据: ${dioException.response?.data}');
    } catch (e) {
      print('❌ 交换 token 失败: $e');
    }
    return null;
  }

  /// 使用授权码交换访问令牌（手动输入模式）
  Future<Map<String, dynamic>?> exchangeCodeForTokenManual(
    String code,
    String codeVerifier,
  ) async {
    print('🔄 开始交换授权码（手动模式）...');
    print('📤 请求 URL: $baseUrl/api/v0/oauth/token');
    print('📤 授权码: $code');

    try {
      final response = await _dio.post(
        '$baseUrl/api/v0/oauth/token',
        data: {
          'client_id': manualClientId,
          'grant_type': 'authorization_code',
          'code': code,
          'redirect_uri': manualRedirectUri,
          'code_verifier': codeVerifier,
        },
        options: Options(contentType: Headers.jsonContentType),
      );

      print('📥 响应状态码: ${response.statusCode}');
      print('📥 响应数据: ${response.data}');

      if (response.statusCode == 200) {
        final apiResponse = LxnsApiResponse<Map<String, dynamic>>.fromJson(
          response.data,
          dataParser: (data) => data as Map<String, dynamic>,
        );

        if (!apiResponse.success) {
          print('❌ API 返回失败: ${apiResponse.message}');
          return null;
        }

        final data = apiResponse.data!;
        final tokenData = {
          'access_token': data['access_token'],
          'refresh_token': data['refresh_token'],
          'token_expiry': DateTime.now()
              .add(Duration(seconds: data['expires_in'] as int))
              .toIso8601String(),
          'scope': data['scope'],
        };

        print('✅ 交换 token 成功');
        return tokenData;
      }
    } on DioException catch (dioException) {
      print('❌ 交换 token 失败 (DioException):');
      print('   错误类型: ${dioException.type}');
      print('   响应数据: ${dioException.response?.data}');
    } catch (e) {
      print('❌ 交换 token 失败: $e');
    }
    return null;
  }
}

/// 落雪咖啡屋 OAuth2 登录页面
class _LxnsOAuth2LoginPage extends StatefulWidget {
  const _LxnsOAuth2LoginPage();

  @override
  State<_LxnsOAuth2LoginPage> createState() => _LxnsOAuth2LoginPageState();
}

class _LxnsOAuth2LoginPageState extends State<_LxnsOAuth2LoginPage> {
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }

  /// 开始 OAuth2 登录流程
  Future<void> _startOAuth2Login() async {
    setState(() => _isLoading = true);

    try {
      final handler = LxnsLoginHandler();
      final result = await handler.performOAuth2Login();

      if (mounted) {
        if (result != null) {
          Navigator.pop(context, result);
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('登录失败，请重试')));
          setState(() => _isLoading = false);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('登录失败: $e')));
        setState(() => _isLoading = false);
      }
    }
  }

  /// 开始手动授权码登录流程
  Future<void> _startManualLogin() async {
    setState(() => _isLoading = true);

    try {
      final handler = LxnsLoginHandler();
      final result = await handler.performManualOAuth2Login();

      if (mounted) {
        if (result != null) {
          Navigator.pop(context, result);
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('登录失败，请重试')));
          setState(() => _isLoading = false);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('登录失败: $e')));
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('落雪咖啡屋登录')),
      body: Column(
        children: [
          // 可滚动内容区域
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Banner 图片 (背景 + 前景叠加)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // 背景图
                        CachedNetworkImage(
                          imageUrl: LxnsLoginHandler.backgroundUrl,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Container(
                              color: colorScheme.surfaceContainerHighest,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Container(
                              color: colorScheme.surfaceContainerHighest,
                              child: Icon(
                                Icons.coffee,
                                size: 64,
                                color: colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                        // 前景图
                        Positioned.fill(
                          child: CachedNetworkImage(
                            imageUrl: LxnsLoginHandler.foregroundUrl,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const SizedBox(),
                            errorWidget: (context, url, error) =>
                                const SizedBox(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '落雪咖啡屋',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '使用 OAuth2 安全授权登录',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // 功能说明
                  Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '登录说明',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '选择一种登录方式：',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '方式1：应用内授权（推荐）\n'
                            '• 在应用内完成授权\n'
                            '• 授权成功后自动返回应用\n\n'
                            '方式2：手动输入授权码\n'
                            '• 适用于应用内授权失败的情况\n'
                            '• 需要手动复制授权码',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 固定在底部的登录按钮
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 自动跳转登录按钮
                  FilledButton.icon(
                    onPressed: _isLoading ? null : _startOAuth2Login,
                    icon: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.login),
                    label: Text(_isLoading ? '登录中...' : '应用内授权登录'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 0),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 手动输入授权码按钮
                  OutlinedButton.icon(
                    onPressed: _isLoading ? null : _startManualLogin,
                    icon: const Icon(Icons.edit),
                    label: const Text('手动输入授权码'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 0),
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
}

/// 手动授权页面（使用 ChromeSafariBrowser）
class _ManualAuthPage extends StatefulWidget {
  final String authUrl;

  const _ManualAuthPage({required this.authUrl});

  @override
  State<_ManualAuthPage> createState() => _ManualAuthPageState();
}

/// OAuth2 授权页面（应用内 WebView）
class _OAuth2WebViewPage extends StatefulWidget {
  final String authUrl;
  final String redirectUri;

  const _OAuth2WebViewPage({
    required this.authUrl,
    required this.redirectUri,
  });

  @override
  State<_OAuth2WebViewPage> createState() => _OAuth2WebViewPageState();
}

class _OAuth2WebViewPageState extends State<_OAuth2WebViewPage> {
  bool _isLoading = true;

  bool _isRedirectMatch(Uri uri) {
    if (uri.scheme == 'rankhub') {
      return true;
    }
    final redirect = Uri.parse(widget.redirectUri);
    return uri.scheme == redirect.scheme &&
        uri.host == redirect.host &&
        uri.path == redirect.path;
  }

  void _handleRedirect(Uri uri) {
    Navigator.pop(context, uri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('落雪咖啡屋授权'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
            tooltip: '关闭',
          ),
        ],
        bottom:
            _isLoading
                ? const PreferredSize(
                  preferredSize: Size.fromHeight(2),
                  child: LinearProgressIndicator(minHeight: 2),
                )
                : null,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(widget.authUrl)),
        initialSettings: InAppWebViewSettings(
          mediaPlaybackRequiresUserGesture: true,
          javaScriptCanOpenWindowsAutomatically: false,
        ),
        onWebViewCreated: (controller) {},
        onLoadStart: (controller, url) {
          if (url != null && _isRedirectMatch(url)) {
            _handleRedirect(url);
          }
        },
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          final uri = navigationAction.request.url;
          if (uri != null && _isRedirectMatch(uri)) {
            _handleRedirect(uri);
            return NavigationActionPolicy.CANCEL;
          }
          return NavigationActionPolicy.ALLOW;
        },
        onLoadStop: (controller, url) async {
          if (mounted) {
            setState(() => _isLoading = false);
          }
        },
        onLoadError: (controller, url, code, message) {
          if (mounted) {
            setState(() => _isLoading = false);
          }
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('页面加载失败：$message')));
        },
      ),
    );
  }
}

class _ManualAuthPageState extends State<_ManualAuthPage> {
  final TextEditingController _codeController = TextEditingController();
  final ChromeSafariBrowser _browser = ChromeSafariBrowser();
  bool _browserOpened = false;

  @override
  void dispose() {
    _codeController.dispose();
    _browser.close();
    super.dispose();
  }

  Future<void> _openBrowser() async {
    if (_browserOpened) return;

    setState(() => _browserOpened = true);

    try {
      // 首先尝试使用 ChromeSafariBrowser
      print('📱 尝试使用 ChromeSafariBrowser 打开浏览器...');
      try {
        await _browser.open(
          url: WebUri(widget.authUrl),
          settings: ChromeSafariBrowserSettings(
            shareState: CustomTabsShareState.SHARE_STATE_OFF,
            barCollapsingEnabled: true,
          ),
        );
        print('✅ ChromeSafariBrowser 打开成功');
        return;
      } on PlatformException catch (e) {
        print('⚠️ ChromeSafariBrowser 打开失败: $e');
        print('📱 降级方案：使用 url_launcher 打开默认浏览器...');
      }

      // 如果 ChromeSafariBrowser 失败，使用 url_launcher 打开默认浏览器
      final Uri authUri = Uri.parse(widget.authUrl);
      if (await canLaunchUrl(authUri)) {
        await launchUrl(authUri, mode: LaunchMode.externalApplication);
        print('✅ 使用 url_launcher 打开浏览器成功');
      } else {
        print('❌ 无法打开 URL: ${widget.authUrl}');
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('无法打开浏览器，请检查 URL')));
        }
        setState(() => _browserOpened = false);
      }
    } catch (e) {
      print('❌ 打开浏览器失败: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('打开浏览器失败: $e')));
      }
      setState(() => _browserOpened = false);
    }
  }

  void _submitCode() {
    final code = _codeController.text.trim();
    if (code.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('请输入授权码')));
      return;
    }
    Navigator.pop(context, code);
  }

  Widget _buildStep(
    BuildContext context,
    String number,
    String title,
    String description,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('授权登录')),
      body: Column(
        children: [
          // 说明区域
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 步骤说明
                  Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '操作步骤',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildStep(
                            context,
                            '1',
                            '点击下方按钮打开浏览器',
                            '在浏览器中登录您的落雪咖啡屋账号',
                          ),
                          const SizedBox(height: 12),
                          _buildStep(context, '2', '完成授权', '在浏览器页面中确认授权'),
                          const SizedBox(height: 12),
                          _buildStep(
                            context,
                            '3',
                            '复制授权码',
                            '授权成功后，页面会显示授权码，请复制',
                          ),
                          const SizedBox(height: 12),
                          _buildStep(context, '4', '粘贴并提交', '返回此页面，粘贴授权码并点击确认'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 打开浏览器按钮
                  FilledButton.icon(
                    onPressed: _browserOpened ? null : _openBrowser,
                    icon: Icon(
                      _browserOpened ? Icons.check : Icons.open_in_browser,
                    ),
                    label: Text(_browserOpened ? '浏览器已打开' : '打开浏览器授权'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 授权码输入区域
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 0,
                    color: colorScheme.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 20,
                            color: colorScheme.onPrimaryContainer,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '完成授权后，页面会显示授权码，请复制并粘贴到下方',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: colorScheme.onPrimaryContainer,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _codeController,
                    decoration: InputDecoration(
                      labelText: '授权码',
                      hintText: '请输入或粘贴授权码',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.vpn_key),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.paste),
                        onPressed: () async {
                          final data = await Clipboard.getData(
                            Clipboard.kTextPlain,
                          );
                          if (data?.text != null) {
                            _codeController.text = data!.text!;
                          }
                        },
                        tooltip: '粘贴',
                      ),
                    ),
                    maxLines: 3,
                    minLines: 1,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _submitCode(),
                  ),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: _submitCode,
                    icon: const Icon(Icons.check),
                    label: const Text('确认登录'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
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
}
