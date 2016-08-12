#! /bin/sh
BASE=$1

ln  -s $BASE/zshrc $HOME/.zshrc

echo "source $BASE/agnoster.zsh-theme" >> $HOME/.zshrc
