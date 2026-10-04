#!/bin/sh

# Check the directory, not `command -v`: ~/.pyenv/bin is only on PATH once a shell rc ran
if [ -d "$HOME/.pyenv" ]; then
  echo "Already pyenv installed!"
else
  curl -fsSL https://pyenv.run | bash
fi
