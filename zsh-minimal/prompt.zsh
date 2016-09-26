# ~/Development/elm/ttt at master <untracked filed><staged files><stash><to-be-pushed><merging|rebasing>
zstyle ':vcs_info:*' enable git
precmd() {
  vcs_info
}

zstyle ':vcs_info:git*+set-message:*' hooks git-staged git-untracked git-modified

+vi-git-staged(){
if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && git status --porcelain | egrep '^(M|D|A|T)' &> /dev/null ; then
        hook_com[staged]+="%{%{$fg[yellow]%}●%{$reset_color%}"
    fi
}

+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[misc]+="%{%{$fg[blue]%}●%{$reset_color%}"
    fi
}

+vi-git-modified(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && git status --porcelain | egrep '^\s(M|D|A|T)' &> /dev/null ; then
        hook_com[misc]+="%{%{$fg[green]%}●%{$reset_color%}"
    fi
}



zstyle ':vcs_info:git*' formats " %{on %{$fg[blue]%}%b%{$reset_color%} %m%u%c% %{$fg[red]%}%a%{$reset_color%}"
PROMPT='%{$fg[magenta]%}$(shrink_path -f)%{$reset_color%}${vcs_info_msg_0_}%{$reset_color%} » '
