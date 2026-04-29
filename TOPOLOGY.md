==================================================
Jellyfin2HQPlayer Three Playback Modes
Topology and Features
==================================================


1. File Mode (Recommended)

+------------------------------+
|      Browser (Web UI)        |
+---------------+--------------+
                |
                | HTTP
                v
+-----------------------------------+
| Jellyfin2HQPlayer Web             |
+----------------+------------------+
                 |
                 | API
                 v

+------------------------------------------------------+
| Host A (Same Machine)                                |
|                                                      |
|  +------------------+   +-------------------------+  |
|  |     Jellyfin     |   |        HQPlayer         |  |
|  |   (Library/Meta) |   |        (Renderer)       |  |
|  +---------+--------+   +------------+------------+  |
|            |                         |               |
|            | Return Path             | Read File     |
|            +-----------+-------------+               |
|                        |                             |
|                        v                             |
|         +-------------------------------+            |
|         |       Local File System       |            |
|         +---------------+---------------+            |
|                         |                            |
+-------------------------+----------------------------+
                          |
            +-------------+-------------+
            |                           |
            v                           v

+----------------------+   +----------------------+
| NAS Mount Path       |   | Local Disk Path      |
| /mnt/NASMusic/...    |   | /local/music/...     |
+----------------------+   +----------------------+

Features:

- Jellyfin and HQPlayer deployed on the same machine
- HQPlayer directly reads local audio files
- No streaming
- No transcoding
- Shortest signal path
- Native bit-perfect playback


2. HTTP File Mode (HQPlayer Recommended)

+------------------------------+
|      Browser (Web UI)        |
+---------------+--------------+
                |
                | HTTP
                v
+------------------------------------+
| Jellyfin2HQPlayer Web              |
+----------------------+-------------+
                       |
                       | API
                       v

+-----------------------------------+
| Host A                            |
|                                   |
|  +-----------------------------+  |
|  |         Jellyfin            |  |
|  |      (Library/HTTP API)     |  |
|  +-------------+---------------+  |
+----------------|------------------+
                 |
                 | HTTP File
                 | sequential stream
                 | no transcoding
                 v

+-----------------------------------+
| Host B                            |
|                                   |
|  +-----------------------------+  |
|  |         HQPlayer            |  |
|  |         (Renderer)          |  |
|  +-------------+---------------+  |
+-----------------------------------+

Features:

- Jellyfin and HQPlayer can be deployed on different machines
- sequential stream model
- no transcoding
- HQPlayer actively pulls audio data
- file-like playback behavior
- bit-perfect


3. HTTP Stream Mode (Compatibility Mode)

+------------------------------+
|      Browser (Web UI)        |
+---------------+--------------+
                |
                | HTTP
                v
+----------------------------------------+
| Jellyfin2HQPlayer Web                  |
+----------------------+-----------------+
                       |
                       | API
                       v

+-----------------------------------+
| Host A                            |
|                                   |
|  +-----------------------------+  |
|  |         Jellyfin            |  |
|  |      (Library/HTTP API)     |  |
|  +-------------+---------------+  |
+----------------|------------------+
                 |
                 | HTTP Stream
                 | Range supported
                 | no transcoding
                 v

+-----------------------------------+
| Host B                            |
|                                   |
|  +-----------------------------+  |
|  |         HQPlayer            |  |
|  |         (Renderer)          |  |
|  +-------------+---------------+  |
+-----------------------------------+

Features:

- Jellyfin and HQPlayer can be deployed on different machines
- random-access stream model
- Range request support
- HTTP stream behavior
- compatible with more player scenarios
- no transcoding
