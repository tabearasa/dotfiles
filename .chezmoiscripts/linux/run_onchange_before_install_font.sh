#!/bin/sh
# Followed guide from:
# https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#option-6-ad-hoc-curl-download
# TODO: install all nerd fonts and set favoritue font as a custom setting also for
# other config files (alacritty.toml,...)
# TODO: add distinction with work pc
# On personal pcs, that should be installed
# system-wide on work pc only on the user level
# TODO: change as template for debian/ubuntu systems

FAVORITE_FONT="FiraCodeNerdFont"
FAVORITE_FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"

if fc-list $FAVORITE_FONT > /dev/null; then
    echo "Your favorite font $FAVORITE_FONT is already installed!"
else
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts && curl -LO $FAVORITE_FONT_URL
    sudo apt-get install unzip
    unzip FiraCode.zip
    fc-cache -f -v ~/.local/share/fonts
fi
