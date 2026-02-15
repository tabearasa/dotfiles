#!/bin/sh
# Followed guide from:
# https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#option-6-ad-hoc-curl-download
# TODO: add distinction with work pc
# On personal pcs, that should be installed
# system-wide on work pc only on the user level
# TODO: Install only one firacode font or the whole zip?
# curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip


FAVORITE_FONT="FiraCode"
FAVORITE_FONT_URL="https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Regular/FiraCodeNerdFont-Regular.ttf"

if fc-list $FAVORITE_FONT > /dev/null; then
    echo "Your favorite font $FAVORITE_FONT is already installed!"
else
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts && curl -fLO $FAVORITE_FONT_URL
fi
