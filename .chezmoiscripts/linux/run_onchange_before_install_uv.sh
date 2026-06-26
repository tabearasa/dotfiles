#!/bin/sh

if command -v uv >/dev/null; then
  echo "Already uv installed!"
else
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi

