source ~/.dotfiles/zsh-minimal/shrink-path.plugin.zsh

source <(antibody init)
antibody bundle mafredri/zsh-async
antibody bundle felipesere/pure

antibody bundle willghatch/zsh-cdr
antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle b4b4r07/enhancd


export ENHANCD_FILTER="/usr/local/bin/fzf --reverse --height 50%"
