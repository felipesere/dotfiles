#! /bin/sh

DIR=$(pwd)

read -r -d '' TEMPLATE <<-EOF
#! /bin/sh
BASE=\$1
EOF

if [[ $1 == "--add" ]]
then
  mkdir $2
  echo "$TEMPLATE" > $DIR/$2/install.sh
  echo "$TEMPLATE" > $DIR/$2/cleanup.sh
  chmod +x $DIR/$2/*.sh
  exit
fi

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
