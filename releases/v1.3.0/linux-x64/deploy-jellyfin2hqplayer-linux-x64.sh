#!/usr/bin/env bash
set -euo pipefail

APP_NAME="jellyfin2hqplayer"
APP_BIN="jellyfin2hqplayer-linux-x64"
APP_DIR="/opt/${APP_NAME}"
SERVICE_NAME="jellyfin2hqplayer"
SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"
PORT="${PORT:-3000}"

APP_TAR="${1:-$(ls -t jellyfin2hqplayer-linux-x64-*.tar.gz 2>/dev/null | head -n1)}"

if [[ -z "${APP_TAR}" || ! -f "${APP_TAR}" ]]; then
  echo "[ERROR] No package found: jellyfin2hqplayer-linux-x64-*.tar.gz"
  echo "Usage:"
  echo "  sudo ./deploy-jellyfin2hqplayer-linux-x64.sh"
  echo "  sudo ./deploy-jellyfin2hqplayer-linux-x64.sh jellyfin2hqplayer-linux-x64-1.0.0.tar.gz"
  echo "  sudo PORT=8080 ./deploy-jellyfin2hqplayer-linux-x64.sh"
  exit 1
fi

if [[ -n "${SUDO_USER:-}" && "${SUDO_USER}" != "root" ]]; then
  REAL_USER="${SUDO_USER}"
else
  REAL_USER="$(id -un)"
fi

REAL_GROUP="$(id -gn "${REAL_USER}")"

echo "[INFO] Package      : ${APP_TAR}"
echo "[INFO] Install dir  : ${APP_DIR}"
echo "[INFO] Binary       : ${APP_BIN}"
echo "[INFO] Service      : ${SERVICE_NAME}"
echo "[INFO] User         : ${REAL_USER}"
echo "[INFO] Group        : ${REAL_GROUP}"
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
sudo mkdir -p "${APP_DIR}"

echo "[STEP] Copy package files"
sudo cp -af "${PKG_DIR}/." "${APP_DIR}/"

echo "[STEP] Set executable permission"
sudo chmod +x "${APP_DIR}/${APP_BIN}"

echo "[STEP] Set ownership"
sudo chown -R "${REAL_USER}:${REAL_GROUP}" "${APP_DIR}"

echo "[STEP] Create/update systemd service"
sudo tee "${SERVICE_FILE}" > /dev/null <<EOF
[Unit]
Description=Jellyfin2HQPlayer
After=network.target

[Service]
Type=simple
WorkingDirectory=${APP_DIR}
ExecStart=${APP_DIR}/${APP_BIN}
Restart=always
RestartSec=3
Environment=PORT=${PORT}
User=${REAL_USER}
Group=${REAL_GROUP}

[Install]
WantedBy=multi-user.target
EOF

echo "[STEP] Reload systemd"
sudo systemctl daemon-reload

echo "[STEP] Enable service"
sudo systemctl enable "${SERVICE_NAME}"

echo "[STEP] Restart service"
sudo systemctl restart "${SERVICE_NAME}"

echo "[STEP] Service status"
sudo systemctl --no-pager --full status "${SERVICE_NAME}" || true

echo
echo "[DONE] Deployment completed."
echo "[INFO] Access URL: http://<your-ip>:${PORT}"
echo
echo "Useful commands:"
echo "  sudo systemctl status ${SERVICE_NAME}"
echo "  sudo journalctl -u ${SERVICE_NAME} -f"
echo "  sudo systemctl restart ${SERVICE_NAME}"
echo "  sudo systemctl stop ${SERVICE_NAME}"
