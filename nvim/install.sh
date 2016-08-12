#! /bin/sh
BASE=$1

ln -sf $BASE $HOME/.config/nvim
nvim --headless -c ":PlugInstall" -c ":qa" 2> /dev/null
