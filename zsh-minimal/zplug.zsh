export ZDOTDIR=$HOME

# Experimental
if [[ `uname` == "Linux" ]]; then
  export ZPLUG_HOME=/usr/share/zplug
elif [[ `uname` == "Darwin" ]]; then
  export ZPLUG_HOME=/opt/homebrew/opt/zplug
else
  echo "Unknown OS!"
fi

if [[ -v ZPLUG_HOME ]]; then
  source $ZPLUG_HOME/init.zsh
  
  zplug "zsh-users/zsh-syntax-highlighting"
  zplug "b4b4r07/enhancd"
  
  # Install plugins if there are plugins that have not been installed
  if ! zplug check --verbose; then
      printf "Install? [y/N]: "
      if read -q; then
          echo; zplug install
      fi
  fi
  
  zplug load
fi
