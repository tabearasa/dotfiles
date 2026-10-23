#!/bin/sh
# Bootstrap a new machine: install chezmoi and apply these dotfiles.
# Not a dotfile (see .chezmoiignore). Run it once on a fresh machine.
# POSIX sh only, so it runs without bash.
#
# Everything runs inside main, so the shell parses the whole script before running it:
# a truncated download does nothing, and commands reading stdin can't eat the piped script.

set -eu

main() {
  sudo apt-get update
  sudo apt-get install -y git

  bin_dir="$HOME/.local/bin"
  export PATH="$bin_dir:$PATH"

  if command -v chezmoi >/dev/null; then
    echo "Already chezmoi installed!"
  else
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$bin_dir"
  fi

  chezmoi init --apply tabearasa </dev/tty

  echo "Done. Once an SSH key is set up, switch the remote to SSH (autoPush):"
  echo "  chezmoi git -- remote set-url origin git@github.com:tabearasa/dotfiles.git"
}

main "$@"
