#!/usr/bin/env bash
set -e

APP_NAME="jellyfin2hqplayer"
INSTALL_DIR="/opt/jellyfin2hqplayer"

echo "Uninstalling Jellyfin2HQPlayer..."

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root:"
  echo "sudo ./uninstall-jellyfin2hqplayer-linux-x64.sh"
  exit 1
fi

echo "Stopping and disabling service..."
systemctl stop "$APP_NAME" 2>/dev/null || true
systemctl disable "$APP_NAME" 2>/dev/null || true

echo "Removing service files..."
rm -f /etc/systemd/system/${APP_NAME}.service
rm -f /lib/systemd/system/${APP_NAME}.service

echo "Reloading systemd..."
systemctl daemon-reexec
systemctl daemon-reload
systemctl reset-failed "$APP_NAME" 2>/dev/null || true

echo "Removing application directory..."
rm -rf "$INSTALL_DIR"

echo
echo "Jellyfin2HQPlayer has been uninstalled."
echo "Verify with: systemctl status jellyfin2hqplayer"
