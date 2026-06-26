#!/bin/sh

if command -v pnpm > /dev/null; then
    echo "pnpm is already installed."
else
    curl -fsSL https://get.pnpm.io/install.sh | sh -
fi

