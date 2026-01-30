import 'package:rank_hub/models/maimai/net_score.dart';
import 'package:rank_hub/models/maimai/score.dart';
import 'package:rank_hub/models/maimai/enums/song_type.dart';
import 'package:rank_hub/modules/lxns/services/maimai_net_api_service.dart';
import 'package:rank_hub/modules/lxns/services/maimai_api_service.dart';
import 'package:rank_hub/modules/lxns/services/maimai_isar_service.dart';

/// NET 成绩同步辅助类
/// 提供统一的 NET 成绩获取和上传逻辑
class NetSyncHelper {
  NetSyncHelper._();

  /// 从 NET 获取成绩并上传到 LXNS 查分器
  ///
  /// [userId] NET 用户 ID
  /// [accessToken] LXNS 访问令牌
  /// [onProgress] 进度回调 (progress 0.0-1.0, message, count)
  ///
  /// 返回上传的成绩数量
  static Future<int> syncNetScoresToLxns({
    required int userId,
    required String accessToken,
    Function(double progress, String message, int count)? onProgress,
  }) async {
    // 1. 从 NET 获取所有成绩 (0% - 50%)
    onProgress?.call(0.0, '正在从 NET 获取成绩...', 0);

    final netScores = await MaimaiNetApiService.instance.getAllUserScores(
      userId,
      onProgress: (current, total, description) {
        final progress = total > 0 ? current / total * 0.5 : 0.0;
        onProgress?.call(progress, description, current);
      },
    );

    // 2. 转换为 Score 对象 (50% - 60%)
    onProgress?.call(0.55, '正在转换成绩数据...', netScores.length);

    final allScores = await _convertNetScoresToScores(netScores);

    // 3. 过滤本地不存在的乐曲 (60% - 70%)
    onProgress?.call(0.65, '正在验证乐曲数据...', allScores.length);

    final scores = await _filterExistingSongs(allScores);

    final filteredCount = allScores.length - scores.length;
    if (filteredCount > 0) {
      print('⚠️ 已过滤 $filteredCount 条本地不存在的乐曲成绩');
    }

    // 4. 上传到 LXNS 查分器 (70% - 100%)
    onProgress?.call(0.7, '正在上传到查分器... (${scores.length}条成绩)', scores.length);

    await MaimaiApiService.instance.uploadScoresToLxns(
      accessToken: accessToken,
      scores: scores,
      onProgress: (current, total, description) {
        final progress = total > 0 ? 0.7 + (current / total * 0.3) : 0.7;
        onProgress?.call(progress, description, scores.length);
      },
    );

    onProgress?.call(1.0, '同步完成！', scores.length);

    return scores.length;
  }

  /// 将 NET 成绩转换为标准 Score 对象
  ///
  /// 根据乐曲 ID 判断谱面类型：
  /// - ID > 10000: DX 谱面，优先使用标准 ID（-10000），
  ///              若标准 ID 不存在则保留 DX ID
  /// - ID <= 10000: 标准谱面
  static Future<List<Score>> _convertNetScoresToScores(
    List<NetScore> netScores,
  ) async {
    final scores = <Score>[];
    final isarService = MaimaiIsarService.instance;

    for (final netScore in netScores) {
      // 只转换有成绩的记录
      if (netScore.achievement > 0) {
        // 根据乐曲 ID 判断谱面类型
        final isDxType = netScore.musicId > 10000;
        final songType = isDxType ? SongType.dx : SongType.standard;

        // DX 谱面优先尝试标准 ID；若标准 ID 不存在则保留 DX ID
        int actualSongId = netScore.musicId;
        if (isDxType) {
          final standardId = netScore.musicId - 10000;
          final standardSong = await isarService.getSongById(standardId);
          actualSongId = standardSong == null ? netScore.musicId : standardId;
        }

        // 先转换为基础 Score
        final baseScore = netScore.toScore(type: songType);

        // 如果需要修正 songId，则构造新对象
        final score = actualSongId == baseScore.songId
            ? baseScore
            : Score(
                songId: actualSongId,
                songName: baseScore.songName,
                level: baseScore.level,
                levelIndex: baseScore.levelIndex,
                achievements: baseScore.achievements,
                fc: baseScore.fc,
                fs: baseScore.fs,
                dxScore: baseScore.dxScore,
                dxStar: baseScore.dxStar,
                dxRating: baseScore.dxRating,
                rate: baseScore.rate,
                type: baseScore.type,
                playTime: baseScore.playTime,
                uploadTime: baseScore.uploadTime,
                lastPlayedTime: baseScore.lastPlayedTime,
              );

        scores.add(score);
      }
    }

    return scores;
  }

  /// 过滤本地数据库中不存在的乐曲
  ///
  /// 只保留本地数据库中存在的乐曲成绩
  static Future<List<Score>> _filterExistingSongs(List<Score> scores) async {
    final isarService = MaimaiIsarService.instance;
    final validScores = <Score>[];

    for (final score in scores) {
      // 检查本地数据库中是否存在该乐曲
      final song = await isarService.getSongById(score.songId);

      if (song != null) {
        validScores.add(score);
      } else {
        print('⚠️ 跳过不存在的乐曲: ID=${score.songId}, Type=${score.type.value}');
      }
    }

    return validScores;
  }
}
