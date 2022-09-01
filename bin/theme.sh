#! /usr/bin/env bash

# Things that need toggling
# - Alacritty
# - Tmux
# - Delta
# - Vim
# - Bat

case $1 in
    light|dark) ;;
    *) echo "Can only toggle between light and dark, not '$1'"; exit -1 ;;
esac

mode=$1

## Alacritty
sd '^colors: .*' "colors: *${mode}" ~/.dotfiles/alacritty/alacritty.yml 

## Tmux
tmux source-file ~/.dotfiles/tmux/${mode}.tmux

## Delta
sd '^features = .*' "features = ${mode}" ~/.dotfiles/git/gitconfig

## Bat
bat_theme=""
if [[ "$mode" = "light" ]]; then
    bat_theme="Monokai Extended Light"
else
    bat_theme="Nord"
fi
sd -- '^--theme.*' "--theme=\"${bat_theme}\"" ~/.dotfiles/bat/bat
