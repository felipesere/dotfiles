#! /usr/bin/env bash

case $1 in
    light|dark) ;;
    *) echo "Can only toggle between light and dark, not '$1'"; exit -1 ;;
esac

mode=$1
case $mode in
    dark) is_dark="true" ;;
    light) is_dark="false" ;;
esac

## Alacritty
ln -sf ~/.dotfiles/alacritty/alacritty.$mode.toml ~/.alacritty.theme.toml
touch ~/.config/alacritty/alacritty.toml

## Tmux
if [[ -v TMUX ]]; then
  tmux source-file ~/.dotfiles/tmux/${mode}.tmux
fi

## Delta
sd '^features = .*' "features = ${mode}" ~/.dotfiles/git/gitconfig

## Vim
echo $mode > ~/.theme

## Bat
bat_theme=""
if [[ "$mode" = "light" ]]; then
    bat_theme="Monokai Extended Light"
else
    bat_theme="Nord"
fi
sd -- '^--theme.*' "--theme=\"${bat_theme}\"" ~/.dotfiles/bat/bat

## OSX
osascript -e "tell app \"System Events\" to tell appearance preferences to set dark mode to ${is_dark}"

