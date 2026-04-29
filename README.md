# Jellyfin2HQPlayer
![Jellyfin2HQPlayer Icon](icons/64x64.png)

**Version 1.3.0**

Jellyfin2HQPlayer is a web control interface for seamless integration between Jellyfin and HQPlayer.

Jellyfin acts as the media library backend, providing complete music management functions, including metadata, artist and album organization, and plugin extensions.  
Jellyfin2HQPlayer serves as the control layer, passing local file paths or HTTP URLs to HQPlayer via API.  
HQPlayer then directly reads the audio data, performs playback, and audio processing, providing a high-quality audio experience.

---

## 1. Playback Architecture

### 1.1 File Mode (Recommended)

When Jellyfin Server and HQPlayer are deployed on the same machine:

- Direct local file access
- No streaming
- No transcoding
- Shortest signal path
- Native bit-perfect playback

HQPlayer directly opens and reads the audio files.

---

### 1.2 HTTP File Mode (HQPlayer Recommended)

The original audio file is transmitted via the Jellyfin HTTP API (no transcoding).

Features:

- Sequential stream model
- Continuous sequential reading
- No Range requests supported
- HQPlayer actively pulls data and controls playback
- Behaves like file-like playback
- Maintains bit-perfect architecture

Used for:

- Jellyfin and HQPlayer deployed on different machines

---

### 1.3 HTTP Stream Mode (Compatibility Mode)

The original audio file is transmitted via the Jellyfin HTTP API (no transcoding).

Features:

- Random-access stream model
- Supports Range requests
- More traditional HTTP Stream behavior
- Compatible with more player scenarios

Used for:

- Jellyfin and HQPlayer deployed on different machines

---

### 1.4 Playback Architecture Topology

[TOPOLOGY.md](TOPOLOGY.md)

---

## 2. Features

- Jellyfin music library integration
- HQPlayer playback control
- File Mode support
- HTTP File Mode support
- HTTP Stream Mode support
- Bit-perfect playback architecture
- Artist / Album / Metadata browsing
- Cover image support
- Lyrics plugin compatibility
- Web control interface
- Browser-based local preview listening
- HQPlayer playback history

---

## 3. Jellyfin Plugin

Jellyfin2HQPlayer Plugin provides:

- Audio file path → Jellyfin ItemId mapping
- REST API routes for Jellyfin2HQPlayer integration

GitHub:

[https://github.com/YTSamLee/Jellyfin2HQPlayer-plugin](https://github.com/YTSamLee/Jellyfin2HQPlayer-plugin)

---

## 4. Design Philosophy

Jellyfin provides complete music management, HQPlayer handles audio playback, and Jellyfin2HQPlayer integrates the two seamlessly.

This architecture achieves:

- Decoupling of the playback chain
- Shortest signal path
- Native bit-perfect playback

---

## 5. Quick Start

### 5.1 Install Jellyfin Server

Links:

- [install-jellyfin-en.txt](install-jellyfin-en.txt)
- [install-jellyfin-cn.txt(中文版)](install-jellyfin-cn.txt)

### 5.2 Deploy Jellyfin2HQPlayer

Links:

- [jellyfin2hqplayer-quickstart-en.txt](jellyfin2hqplayer-quickstart-en.txt)
- [jellyfin2hqplayer-quickstart-cn.txt(中文版)](jellyfin2hqplayer-quickstart-cn.txt)

### 5.3 Deploy Jellyfin2HQPlayerPlugin

Links:

- [Jellyfin2HQPlayerPlugin-en.txt](Jellyfin2HQPlayerPlugin-en.txt)
- [Jellyfin2HQPlayerPlugin-cn.txt(中文版)](Jellyfin2HQPlayerPlugin-cn.txt)

---

## 6. Contact Information

YTSam

Email: 563422071@qq.com

---

### 中文版本

如需查看中文版本，请访问 [README-cn.md](README-cn.md)
