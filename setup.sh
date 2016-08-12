#! /bin/sh

DIR=$(pwd)

for dir in $(ls -d */)
do
  project=${dir%?}
  if [[ $1 == "--clean" ]]
  then
    cleanup=$DIR/$project/cleanup.sh
    if [[ -e $cleanup ]]
    then
      echo "cleaning up $dir"
      $cleanup $DIR/$project
    fi
  else
    install=$DIR/$project/install.sh
    if [[ -e $install ]]
    then
      echo "setting up $dir"
      $install $DIR/$project
    fi
  fi
done
