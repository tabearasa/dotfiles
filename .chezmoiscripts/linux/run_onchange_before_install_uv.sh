#!/bin/sh

if command uv > /dev/null; then
    echo "Already uv installed!"
else
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi