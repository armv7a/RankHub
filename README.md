<p>
  <img src="icon-1024.png" alt="RankHub Logo" width="120" height="120">
</p>

# ⚠️ 施工中：本 fork 仅保留 maimai 功能，暂不可使用，本项目当前使用 force push，请窒息

# RankHub - 音游数据管理平台

RankHub 是一个基于 Flutter 开发的跨平台音游数据管理应用，支持多平台账号管理、数据同步、成绩查询和其他功能。

幻想打造一个聚合音游平台。

## 下载安装

### iOS

加入QQ群获取 TestFlight 链接：1073434398

[![下载 iOS IPA](https://img.shields.io/badge/下载-iOS%20IPA-blue?style=for-the-badge&logo=apple)](https://github.com/qianmo2233/RankHub/releases/latest)

使用 [AltStore](https://altstore.io/)、[Sideloadly](https://sideloadly.io/) 或其他签名工具安装到设备

> **注意**：未签名的 IPA 需要自行签名才能安装到 iOS 设备。推荐使用 AltStore 或 Sideloadly 进行侧载安装。


### Android

[![下载 Android APK](https://img.shields.io/badge/下载-Android%20APK-green?style=for-the-badge&logo=android)](https://github.com/qianmo2233/RankHub/releases/latest)

根据设备架构下载对应的 APK：
   - **arm64-v8a**：适用于大多数现代 Android 设备（推荐）
   - **armeabi-v7a**：适用于较旧的 32 位 ARM 设备
   - **x86_64**：适用于模拟器或 x86 架构设备
传输到 Android 设备并安装

> **提示**：如果不确定选择哪个版本，优先下载 **arm64-v8a** 版本。安装前需要在设备设置中允许"安装未知来源应用"。

### 从源码构建

```bash
# 克隆仓库
git clone https://github.com/qianmo2233/RankHub.git
cd RankHub

# 安装依赖
flutter pub get

# 生成代码（必需）
dart run build_runner build --delete-conflicting-outputs

# iOS 构建
flutter build ios --release

# Android 构建
flutter build apk --split-per-abi
```

## 项目概述

### 应用截图

<div align="center">
  <img src="screenshots/Simulator Screenshot - iPhone 17 Pro - 2025-11-20 at 18.38.29-portrait.png" width="120" />
  <img src="screenshots/Simulator Screenshot - iPhone 17 Pro - 2025-11-20 at 18.39.00-portrait.png" width="120" />
  <img src="screenshots/Simulator Screenshot - iPhone 17 Pro - 2025-11-20 at 18.39.54-portrait.png" width="120" />
  <img src="screenshots/Simulator Screenshot - iPhone 17 Pro - 2025-11-20 at 18.40.24-portrait.png" width="120" />
  <img src="screenshots/Simulator Screenshot - iPhone 17 Pro - 2025-11-20 at 18.40.42-portrait.png" width="120" />
  <img src="screenshots/Simulator Screenshot - iPhone 17 Pro - 2025-11-20 at 18.41.12-portrait.png" width="120" />
</div>

### 核心功能
- **多平台支持**：支持落雪咖啡屋（LXNS）、MuseDash.moe等多个音游数据平台
- **多游戏支持**：支持舞萌DX、喵斯快跑等多款音游
- **账号管理**：多账号绑定、OAuth2/API Key 认证
- **数据同步**：智能数据同步，支持全量和增量同步
- **数据展示**：Wiki、Rank、个人页面等多维度数据展示
- **本地存储**：基于 Isar 的高性能本地数据库

### 平台与游戏支持

<table>
<thead>
  <tr>
    <th>平台</th>
    <th>游戏</th>
    <th>认证方式</th>
    <th>功能特性</th>
    <th>状态</th>
    <th>说明</th>
  </tr>
</thead>
<tbody>

  <!-- 落雪咖啡屋 舞萌DX -->
  <tr>
    <td rowspan="24"><b>落雪咖啡屋</b><br/><sub>LXNS</sub></td>
    <td rowspan="18"><b>舞萌DX</b></td>
    <td rowspan="18">OAuth2</td>
    <td>曲目列表</td>
    <td align="center">✅</td>
    <td>完整曲目数据库，支持搜索和筛选</td>
  </tr>
  <tr>
    <td>成绩查询</td>
    <td align="center">✅</td>
    <td>所有难度成绩记录</td>
  </tr>
  <tr>
    <td>B50 分析</td>
    <td align="center">✅</td>
    <td>Best 50 成绩分表展示</td>
  </tr>
  <tr>
    <td>收藏品</td>
    <td align="center">✅</td>
    <td>角色、姓名框、背景等收藏品数据</td>
  </tr>
  <tr>
    <td>玩家信息</td>
    <td align="center">✅</td>
    <td>DX Rating、游玩数据统计</td>
  </tr>
  <tr>
    <td>曲绘显示</td>
    <td align="center">✅</td>
    <td>支持曲绘缓存</td>
  </tr>
  <tr>
    <td>数据同步</td>
    <td align="center">✅</td>
    <td>自动同步所有数据</td>
  </tr>
  <tr>
    <td>单曲 Rating 计算</td>
    <td align="center">⏳</td>
    <td>开发中</td>
  </tr>
  <tr>
    <td>达成率容错计算</td>
    <td align="center">⏳</td>
    <td>开发中</td>
  </tr>
  <tr>
    <td>保存曲绘/藏品图片到相册</td>
    <td align="center">⏳</td>
    <td>开发中</td>
  </tr>
  <tr>
    <td>从 Net 同步玩家数据</td>
    <td align="center">📋</td>
    <td>计划中</td>
  </tr>
  <tr>
    <td>数据导出</td>
    <td align="center">📋</td>
    <td>计划中</td>
  </tr>
  <tr>
    <td>B50 图片生成</td>
    <td align="center">📋</td>
    <td>计划中</td>
  </tr>
  <tr>
    <td>单曲评论与评分</td>
    <td align="center">📋</td>
    <td>计划中</td>
  </tr>
  <tr>
    <td>别名投票</td>
    <td align="center">📋</td>
    <td>计划中</td>
  </tr>
  <tr>
    <td>完成率分布计算</td>
    <td align="center">📋</td>
    <td>计划中</td>
  </tr>
  <tr>
    <td>乐曲试听</td>
    <td align="center">📋</td>
    <td>计划中</td>
  </tr>
  <tr>
    <td>Simai 谱面下载</td>
    <td align="center">📋</td>
    <td>计划中</td>
  </tr>


</tbody>
</table>

#### 图例说明

- ✅ **已完成** - 功能完整，稳定可用
- ⏳ **开发中** - 正在实现
- 📋 **计划中** - 已列入开发计划
- ❌ **暂不支持** - 暂无计划或技术限制

## 开发文档

[DeepWiki](https://deepwiki.com/qianmo2233/RankHub?tab=readme-ov-file)


## 贡献指南

1. Fork 本项目
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 提交 Pull Request


## 许可证

本项目采用 MIT 许可证 - 详见 LICENSE 文件


## 联系方式

项目维护者：QianMo SAMA

问题反馈：请在 GitHub Issues 中提交
