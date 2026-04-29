#!/usr/bin/env bash
set -euo pipefail

APP_NAME="jellyfin2hqplayer"
APP_BIN="jellyfin2hqplayer-macos-arm64"
APP_DIR="${HOME}/${APP_NAME}"

PLIST_LABEL="com.jellyfin2hqplayer"
PLIST_DIR="${HOME}/Library/LaunchAgents"
PLIST_FILE="${PLIST_DIR}/${PLIST_LABEL}.plist"

PORT="${PORT:-3000}"
APP_TAR="${1:-$(ls -t jellyfin2hqplayer-macos-arm64-*.tar.gz 2>/dev/null | head -n1)}"

if [[ -z "${APP_TAR}" || ! -f "${APP_TAR}" ]]; then
  echo "[ERROR] No package found: jellyfin2hqplayer-macos-arm64-*.tar.gz"
  echo "Usage:"
  echo "  ./deploy-jellyfin2hqplayer-macos-arm64.sh"
  echo "  ./deploy-jellyfin2hqplayer-macos-arm64.sh jellyfin2hqplayer-macos-arm64-1.0.0.tar.gz"
  echo "  PORT=8080 ./deploy-jellyfin2hqplayer-macos-arm64.sh"
  exit 1
fi

echo "[INFO] Package      : ${APP_TAR}"
echo "[INFO] Install dir  : ${APP_DIR}"
echo "[INFO] Binary       : ${APP_BIN}"
echo "[INFO] Plist        : ${PLIST_FILE}"
echo "[INFO] Port         : ${PORT}"
echo

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

echo "[STEP] Extract package to temp dir"
tar -xzf "${APP_TAR}" -C "${TMP_DIR}"

PKG_DIR="${TMP_DIR}/${APP_NAME}"
if [[ ! -d "${PKG_DIR}" ]]; then
  echo "[ERROR] Package structure invalid: ${PKG_DIR} not found"
  exit 1
fi

if [[ ! -f "${PKG_DIR}/${APP_BIN}" ]]; then
  echo "[ERROR] Binary not found in package: ${PKG_DIR}/${APP_BIN}"
  exit 1
fi

echo "[STEP] Create install dir"
mkdir -p "${APP_DIR}"

echo "[STEP] Copy package files"
cp -af "${PKG_DIR}/." "${APP_DIR}/"

echo "[STEP] Set executable permission"
chmod +x "${APP_DIR}/${APP_BIN}"

echo "[STEP] Create LaunchAgents dir"
mkdir -p "${PLIST_DIR}"

echo "[STEP] Remove old service if exists"
launchctl bootout "gui/$(id -u)/${PLIST_LABEL}" 2>/dev/null || true
rm -f "${PLIST_FILE}"

echo "[STEP] Write plist"
cat > "${PLIST_FILE}" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
 "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>

  <key>Label</key>
  <string>${PLIST_LABEL}</string>

  <key>ProgramArguments</key>
  <array>
    <string>${APP_DIR}/${APP_BIN}</string>
  </array>

  <key>WorkingDirectory</key>
  <string>${APP_DIR}</string>

  <key>RunAtLoad</key>
  <true/>

  <key>KeepAlive</key>
  <true/>

  <key>EnvironmentVariables</key>
  <dict>
    <key>PORT</key>
    <string>${PORT}</string>
  </dict>

  <key>StandardOutPath</key>
  <string>/tmp/jellyfin2hqplayer.log</string>

  <key>StandardErrorPath</key>
  <string>/tmp/jellyfin2hqplayer.err</string>

</dict>
</plist>
EOF

echo "[STEP] Validate plist"
plutil "${PLIST_FILE}" >/dev/null

echo "[STEP] Bootstrap service"
launchctl bootstrap "gui/$(id -u)" "${PLIST_FILE}"

echo "[STEP] Enable service"
launchctl enable "gui/$(id -u)/${PLIST_LABEL}"

echo "[STEP] Restart service"
launchctl kickstart -k "gui/$(id -u)/${PLIST_LABEL}"

echo "[STEP] Service status"
launchctl print "gui/$(id -u)/${PLIST_LABEL}" | sed -n '1,80p'

echo
echo "[DONE] Deployment completed."
echo "[INFO] Access URL: http://<your-ip>:${PORT}"
echo
echo "[NOTE] If macOS blocks background activity, enable it in:"
echo "       System Settings → General → Login Items → Allow jellyfin2hqplayer"
echo
echo "Useful commands:"
echo "  launchctl print gui/\$(id -u)/${PLIST_LABEL}"
echo "  launchctl kickstart -k gui/\$(id -u)/${PLIST_LABEL}"
echo "  launchctl bootout gui/\$(id -u)/${PLIST_LABEL}"
echo "  tail -f /tmp/jellyfin2hqplayer.log"
echo "  tail -f /tmp/jellyfin2hqplayer.err"
