
# Jellyfin2HQPlayer
![Jellyfin2HQPlayer Icon](icons/64x64.png)

**版本 1.3.0**

Jellyfin2HQPlayer 是一个 Web 控制界面，用于实现 Jellyfin 和 HQPlayer 的无缝集成。

Jellyfin 作为媒体库后端，提供完整的音乐管理功能，包括元数据、艺术家和专辑组织，以及插件扩展。
Jellyfin2HQPlayer 作为控制层，通过 API 将本地文件路径或 HTTP URL 传递给 HQPlayer。
HQPlayer 然后直接读取音频数据，执行播放和音频处理，提供高质量的音频体验。

---

## 1. 播放架构

### 1.1 文件模式（推荐）

当 Jellyfin 服务器和 HQPlayer 部署在同一台机器上时：

- 直接本地文件访问
- 无流媒体传输
- 无转码
- 最短信号路径
- 原生 bit-perfect 播放

HQPlayer 直接打开并读取音频文件。

---

### 1.2 HTTP 文件模式（HQPlayer 推荐）

原始音频文件通过 Jellyfin HTTP API 传输（正确配置时无转码）。

特性：

- 类文件顺序访问（sequential stream model）
- 连续顺序读取
- 不支持 Range 请求
- HQPlayer 主动拉取音频数据
- 行为类似本地文件访问
- 保留播放控制

适用于：

- Jellyfin 和 HQPlayer 部署在不同机器上

---

### 1.3 HTTP 流模式（兼容模式）

原始音频文件通过 Jellyfin HTTP API 传输（无转码）。

特性：

- 带 Range 访问的 HTTP 流（random-access stream model）
- 支持 Range 请求
- 标准 HTTP 流行为

适用于：

- Jellyfin 和 HQPlayer 部署在不同机器上

---

### 1.4 播放架构拓扑

[English](TOPOLOGY.md) | [中文](TOPOLOGY-cn.md)

---

## 2. 特性

- Jellyfin 音乐库集成
- HQPlayer 播放控制
- 支持文件模式
- 支持 HTTP 文件模式
- 支持 HTTP 流模式
- bit-perfect 播放架构
- 艺术家 / 专辑 / 元数据浏览
- 封面图支持
- 歌词插件兼容
- Web 控制界面
- 浏览器本地预览播放
- HQPlayer 播放历史

---

## 2.1 截图

### 桌面 UI

播放视图

<img src="screenshots/desktop/playing.png" width="800">

HQPlayer 队列

<img src="screenshots/desktop/hqplayer-queue.png" width="800">

频谱分析仪

<img src="screenshots/desktop/spectrum.png" width="800">

声谱图

<img src="screenshots/desktop/spectrogram.png" width="800">

VU 表

<img src="screenshots/desktop/vumeter.png" width="800">

---

### 移动端 UI

<table>
  <tr>
    <td>
      <div align="center">Playing View</div>
      <img src="screenshots/mobile/playing.png" width="250">
    </td>
    <td>
      <div align="center">Settings</div>
      <img src="screenshots/mobile/setting.png" width="250">
    </td>
  </tr>
  <tr>
    <td>
      <div align="center">Spectrum Analyzer</div>
      <img src="screenshots/mobile/spectrum.png" width="250">
    </td>
    <td>
      <div align="center">Spectrogram</div>
      <img src="screenshots/mobile/spectrogram.png" width="250">
    </td>
  </tr>
  <tr>
    <td>
      <div align="center">VU Meter</div>
      <img src="screenshots/mobile/vumeter.png" width="250">
    </td>
    <td>
      <div align="center">Home</div>
      <img src="screenshots/mobile/home.jpg" width="250">
    </td>
  </tr>
  <tr>
    <td>
      <div align="center">ArtistDetails</div>
      <img src="screenshots/mobile/artistdetails.jpg" width="250">
    </td>
    <td>
      <div align="center">AlbumDetails</div>
      <img src="screenshots/mobile/albumdetails.jpg" width="250">
    </td>
  </tr>
  <tr>
    <td>
      <div align="center">Suggestions</div>
      <img src="screenshots/mobile/suggestions.jpg" width="250">
    </td>
    <td>
      <div align="center">Search</div>
      <img src="screenshots/mobile/search.jpg" width="250">
    </td>
  </tr>
</table>

---

## 3. Jellyfin 插件

Jellyfin2HQPlayer 插件提供：

- 音频文件路径 → Jellyfin ItemId 映射
- 用于 Jellyfin2HQPlayer 集成的 REST API 路由

GitHub：

[https://github.com/YTSamLee/Jellyfin2HQPlayer-plugin](https://github.com/YTSamLee/Jellyfin2HQPlayer-plugin)

---

## 4. 设计哲学

Jellyfin 提供完整的音乐管理，HQPlayer 处理音频播放，Jellyfin2HQPlayer 实现两者的无缝集成。

该架构实现了：

- 播放链的解耦
- 最短信号路径
- 原生 bit-perfect 播放

---

## 5. 快速开始

### 5.1 安装 Jellyfin 服务器

链接：

- [English](install-jellyfin-en.txt) | [中文](install-jellyfin-cn.txt)

### 5.2 部署 Jellyfin2HQPlayer

链接：

- [English](jellyfin2hqplayer-quickstart-en.txt) | [中文](jellyfin2hqplayer-quickstart-cn.txt)

### 5.3 部署 Jellyfin2HQPlayerPlugin

链接：

- [English](Jellyfin2HQPlayerPlugin-en.txt) | [中文](Jellyfin2HQPlayerPlugin-cn.txt)

---

## 6. 联系信息

YTSam

Email: 563422071@qq.com

---

## 许可协议

Jellyfin2HQPlayer 是闭源专有软件，仅以二进制形式发布，不提供源代码。

允许个人及非商业用途使用。  
商业使用需要获得明确的书面许可。

完整条款请查看 [LICENSE](./LICENSE) 文件。

---

### English Version

[README English](README.md)
