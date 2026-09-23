#!/usr/bin/env bash
# Jassie Code CLI installer for Linux (Ubuntu/Debian).
# Usage: curl -fsSL https://raw.githubusercontent.com/Jassie-AI/homebrew-jassie/main/install.sh | sudo bash
set -euo pipefail

REPO="Jassie-AI/homebrew-jassie"

# ── Pre-flight checks ────────────────────────────────────────────────
if [ "$(id -u)" -ne 0 ]; then
  echo "Error: this installer must be run as root (use sudo)." >&2
  exit 1
fi

if ! command -v dpkg >/dev/null 2>&1; then
  echo "Error: dpkg not found. This installer supports Debian/Ubuntu only." >&2
  echo "On other distros, install from source or use Homebrew." >&2
  exit 1
fi

# ── Detect latest release ────────────────────────────────────────────
echo "Fetching latest Jassie release..."
if command -v curl >/dev/null 2>&1; then
  LATEST_URL=$(curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest" \
    | grep -oP '"browser_download_url":\s*"\K[^"]*\.deb')
elif command -v wget >/dev/null 2>&1; then
  LATEST_URL=$(wget -qO- "https://api.github.com/repos/${REPO}/releases/latest" \
    | grep -oP '"browser_download_url":\s*"\K[^"]*\.deb')
else
  echo "Error: curl or wget is required." >&2
  exit 1
fi

if [ -z "$LATEST_URL" ]; then
  echo "Error: could not find a .deb in the latest release." >&2
  exit 1
fi

echo "Downloading: $LATEST_URL"

# ── Download and install ─────────────────────────────────────────────
TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

DEB_FILE="$TMPDIR/jassie.deb"
if command -v curl >/dev/null 2>&1; then
  curl -fsSL -o "$DEB_FILE" "$LATEST_URL"
else
  wget -qO "$DEB_FILE" "$LATEST_URL"
fi

dpkg -i "$DEB_FILE" || true
apt-get install -f -y

# ── Verify ────────────────────────────────────────────────────────────
if command -v jassie >/dev/null 2>&1; then
  echo ""
  echo "Jassie Code CLI installed successfully!"
  jassie --version
else
  echo "Warning: 'jassie' command not found on PATH after install." >&2
  echo "You may need to restart your shell." >&2
fi
