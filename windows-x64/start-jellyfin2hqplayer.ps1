$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Start-Process `
  "$scriptDir\jellyfin2hqplayer-win-x64.exe" `
  -WindowStyle Hidden