#!/usr/bin/env bash
set -e

APP_NAME="jellyfin2hqplayer"
LABEL="com.jellyfin2hqplayer"
INSTALL_DIR="$HOME/jellyfin2hqplayer"
PLIST_FILE="$HOME/Library/LaunchAgents/${LABEL}.plist"

echo "Uninstalling Jellyfin2HQPlayer for macOS..."

echo "Stopping LaunchAgent..."
launchctl bootout "gui/$(id -u)/${LABEL}" 2>/dev/null || true
launchctl remove "$LABEL" 2>/dev/null || true

echo "Removing LaunchAgent plist..."
rm -f "$PLIST_FILE"

echo "Removing application directory..."
rm -rf "$INSTALL_DIR"

echo "Removing log files..."
rm -f /tmp/jellyfin2hqplayer.log
rm -f /tmp/jellyfin2hqplayer.err

echo
echo "Jellyfin2HQPlayer has been uninstalled."
echo "Verify (should NOT exist):"
echo "launchctl print gui/$(id -u)/${LABEL}"
