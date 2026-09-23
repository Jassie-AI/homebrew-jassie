#!/usr/bin/env bash
# Jassie Code CLI installer for Linux and macOS.
# Usage: curl -fsSL https://raw.githubusercontent.com/Jassie-AI/homebrew-jassie/main/install.sh | bash
set -euo pipefail

REPO="Jassie-AI/homebrew-jassie"
INSTALL_DIR="${JASSIE_INSTALL_DIR:-/usr/local/bin}"

# ── Detect platform ──────────────────────────────────────────────────
OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
  Linux)   PLATFORM="linux" ;;
  Darwin)  PLATFORM="darwin" ;;
  *)       echo "Error: unsupported OS: $OS" >&2; exit 1 ;;
esac

case "$ARCH" in
  x86_64|amd64)   ARCH_NAME="x64" ;;
  aarch64|arm64)   ARCH_NAME="arm64" ;;
  *)               echo "Error: unsupported architecture: $ARCH" >&2; exit 1 ;;
esac

BINARY_NAME="jassie-${PLATFORM}-${ARCH_NAME}"

# ── Check permissions ────────────────────────────────────────────────
NEED_SUDO=""
if [ ! -w "$INSTALL_DIR" ]; then
  if [ "$(id -u)" -ne 0 ]; then
    NEED_SUDO="sudo"
    echo "Note: installing to $INSTALL_DIR requires sudo."
  fi
fi

# ── Detect latest release ────────────────────────────────────────────
echo "Fetching latest Jassie release..."
if command -v curl >/dev/null 2>&1; then
  FETCH="curl -fsSL"
elif command -v wget >/dev/null 2>&1; then
  FETCH="wget -qO-"
else
  echo "Error: curl or wget is required." >&2
  exit 1
fi

RELEASE_JSON=$($FETCH "https://api.github.com/repos/${REPO}/releases/latest")
VERSION=$(echo "$RELEASE_JSON" | grep -o '"tag_name": *"[^"]*"' | head -1 | sed 's/.*"v\{0,1\}\([^"]*\)".*/\1/')
DOWNLOAD_URL="https://github.com/${REPO}/releases/download/v${VERSION}/${BINARY_NAME}"

echo "Installing Jassie v${VERSION} (${PLATFORM}/${ARCH_NAME})..."

# ── Download and install ─────────────────────────────────────────────
TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

BINARY_FILE="$TMPDIR/jassie"
if command -v curl >/dev/null 2>&1; then
  curl -fsSL -o "$BINARY_FILE" "$DOWNLOAD_URL"
else
  wget -qO "$BINARY_FILE" "$DOWNLOAD_URL"
fi

chmod +x "$BINARY_FILE"

# Verify the binary runs
if ! "$BINARY_FILE" --version >/dev/null 2>&1; then
  echo "Error: downloaded binary failed to execute." >&2
  exit 1
fi

$NEED_SUDO mkdir -p "$INSTALL_DIR"
$NEED_SUDO mv "$BINARY_FILE" "$INSTALL_DIR/jassie"

# ── Verify ────────────────────────────────────────────────────────────
if command -v jassie >/dev/null 2>&1; then
  echo ""
  echo "Jassie Code CLI installed successfully!"
  jassie --version
else
  echo ""
  echo "Installed to $INSTALL_DIR/jassie"
  echo "Make sure $INSTALL_DIR is in your PATH."
fi
