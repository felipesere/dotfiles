#! /usr/bin/env bash

case $1 in
light | dark) ;;
*)
  echo "Can only toggle between light and dark, not '$1'"
  exit -1
  ;;
esac

case $1 in
dark)
  is_dark="true"
  ;;
light)
  is_dark="false"
  ;;
esac

## OSX
osascript -e "tell app \"System Events\" to tell appearance preferences to set dark mode to ${is_dark}"
