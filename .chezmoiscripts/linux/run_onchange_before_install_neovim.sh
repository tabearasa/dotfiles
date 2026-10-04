#!/usr/bin/env bash
set -euo pipefail

# apt's neovim is too old for LazyVim v15 (needs >= 0.11.2): Debian trixie ships 0.10, Ubuntu 24.04 0.9.
# Install the latest release tarball to /opt instead.
# https://github.com/neovim/neovim/blob/master/INSTALL.md#pre-built-archives-2
MIN_VERSION="0.11.2"

if command -v nvim >/dev/null; then
    CURRENT_VERSION="$(nvim --version | head -1 | sed 's/^NVIM v//')"
    if [ "$(printf '%s\n' "$MIN_VERSION" "$CURRENT_VERSION" | sort -V | head -1)" = "$MIN_VERSION" ]; then
        echo "Neovim $CURRENT_VERSION is already installed."
        exit 0
    fi
fi

case "$(uname -m)" in
    x86_64) NVIM_NAME="nvim-linux-x86_64" ;;
    aarch64 | arm64) NVIM_NAME="nvim-linux-arm64" ;;
    *) echo "neovim: unsupported architecture $(uname -m), skipping." && exit 0 ;;
esac

echo "====== Installing latest Neovim ======"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

curl -fL -o "$TMP_DIR/$NVIM_NAME.tar.gz" \
    "https://github.com/neovim/neovim/releases/latest/download/$NVIM_NAME.tar.gz"
sudo rm -rf "/opt/$NVIM_NAME"
sudo tar -C /opt -xzf "$TMP_DIR/$NVIM_NAME.tar.gz"
sudo ln -sf "/opt/$NVIM_NAME/bin/nvim" /usr/local/bin/nvim
