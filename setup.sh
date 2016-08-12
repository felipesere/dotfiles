#! /bin/sh

DIR=$(pwd)

if [[ $1 == "--dry-run" ]]
then
  for dir in $(ls -d */)
  do
    echo $DIR/$dir
  done
  exit
fi
# cleanup git
if [[ $1 == "--clean" ]]
then
  echo "cleaning up git"
  unlink $HOME/.gitconfig
  unlink $HOME/.githelper
  unlink $HOME/.gitignore
else
  echo "setting up git"
  ln -s $DIR/git/gitconfig  $HOME/.gitconfig
  ln -s $DIR/git/githelper  $HOME/.githelper
  ln -s $DIR/git/gitignore  $HOME/.gitignore
fi

#setup neovim
if [[ $1 == "--clean" ]]
then
  echo "cleaning up nvim"
  unlink $HOME/.config/nvim
else
  echo "setup up nvim"
  ln -s $DIR/nvim $HOME/.config/nvim
  nvim --headless -c ":PlugInstall" -c ":qa" 2> /dev/null  
fi
