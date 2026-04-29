# Jellyfin2HQPlayer

**Version 1.3.0**

Jellyfin2HQPlayer 是一个 Web 控制界面，用于实现 Jellyfin 与 HQPlayer 的无缝集成。

Jellyfin 作为媒体库后端，提供完整的音乐管理功能，包括元数据、艺术家与专辑的组织以及插件扩展等。  
Jellyfin2HQPlayer 作为控制层，通过 API 将本地文件路径或 HTTP URL 传递给 HQPlayer。  
HQPlayer 则直接读取音频数据，完成播放和音频处理，提供高质量的音频体验。

---

## 1. 播放架构

### 1.1 File Mode（推荐）

当 Jellyfin Server 与 HQPlayer 部署在同一主机时：

- 直接本地文件访问
- 无流式传输
- 无转码
- 最短信号路径
- 原生 bit-perfect 播放

HQPlayer 直接打开并读取音频文件。

---

### 1.2 HTTP File Mode（HQPlayer 推荐）

通过 Jellyfin HTTP API 传输原始音频文件（无转码）。

特点：

- sequential stream model
- 连续顺序读取
- 不支持 Range 请求
- HQPlayer 主动拉取数据并掌控播放
- 整体行为接近 file-like playback
- 保持 bit-perfect 架构

适用于：

- Jellyfin 与 HQPlayer 部署在不同主机

---

### 1.3 HTTP Stream Mode（兼容模式）

通过 Jellyfin HTTP API 传输原始音频文件（无转码）。

特点：

- random-access stream model
- 支持 Range 请求
- 更偏向传统 HTTP Stream 行为
- 兼容更多播放器与浏览器场景

适用于：

- Jellyfin 与 HQPlayer 部署在不同主机

---

### 1.4 播放架构拓扑图

[TOPOLOGY.md](TOPOLOGY.md)

---

## 2. 功能特性

- Jellyfin 音乐库集成
- HQPlayer 播放控制
- File Mode 支持
- HTTP File Mode 支持
- HTTP Stream Mode 支持
- Bit-perfect 播放架构
- 艺术家 / 专辑 / 元数据浏览
- 封面图支持
- 歌词插件兼容
- Web 控制界面
- 浏览器本地预览试听
- HQPlayer 播放历史记录

---

## 3. Jellyfin 插件

Jellyfin2HQPlayer Plugin 提供：

- 音频文件路径 → Jellyfin ItemId 映射
- 用于 Jellyfin2HQPlayer 集成的 REST API 路由

GitHub：

[https://github.com/YTSamLee/Jellyfin2HQPlayer-plugin](https://github.com/YTSamLee/Jellyfin2HQPlayer-plugin)

---

## 4. 设计理念

Jellyfin 提供完整的音乐管理能力，HQPlayer 负责音频播放，Jellyfin2HQPlayer 实现两者的无缝连接。

这种架构实现了：

- 播放链路解耦
- 最短信号路径
- 原生 bit-perfect 播放

---

## 5. 快速开始

### 5.1 安装 Jellyfin Server

链接：

- [install-jellyfin-en.txt](install-jellyfin-en.txt)
- [install-jellyfin-cn.txt](install-jellyfin-cn.txt)

### 5.2 部署 Jellyfin2HQPlayer

链接：

- [jellyfin2hqplayer-quickstart-en.txt](jellyfin2hqplayer-quickstart-en.txt)
- [jellyfin2hqplayer-quickstart-cn.txt](jellyfin2hqplayer-quickstart-cn.txt)

### 5.3 部署 Jellyfin2HQPlayerPlugin

链接：

- [Jellyfin2HQPlayerPlugin-en.txt](Jellyfin2HQPlayerPlugin-en.txt)
- [Jellyfin2HQPlayerPlugin-cn.txt](Jellyfin2HQPlayerPlugin-cn.txt)

---

## 6. 联系方式

YTSam

邮箱：563422071@qq.com
