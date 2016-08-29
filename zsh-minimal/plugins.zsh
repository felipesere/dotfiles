export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "willghatch/zsh-cdr"
zplug "plugins/shrink-path",   from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", nice:10
zplug "b4b4r07/enhancd", use:init.sh

zplug load
