$env.config = ($env.config 
  | upsert show_banner false
  | upsert hooks {
    env_change: {
      PWD: [{|_,_| title }]
    }
  }
)
source ~/.zoxide.nu
source ~/.dotfiles/nushell/atuin.nu
source ~/.dotfiles/nushell/theme.nu
source ~/.dotfiles/nushell/fnm.nu
source ~/.dotfiles/nushell/k8s.nu
source ~/.cache/carapace/init.nu

use ~/.dotfiles/starship/starship.nu

alias nu-open = open
alias open = ^open
alias fg = job unfreeze
alias vim = nvim
alias light = set-theme "light"
alias dark = set-theme "dark"

def --env c [] {
  let in_repo = (git rev-parse --is-inside-work-tree | complete)

  if $in_repo.exit_code == 0 {
    cd (git root)
  }
}


def --env dots [] {
  cd ~/.dotfiles
}

def font_size [size] {
  open ~/.alacritty-font-size.toml | update font.size $size | to toml | save -f ~/.alacritty-font-size.toml
}

def laptop [] { font_size 16 }
def normal [] { font_size 24 }
def presentatation [] { font_size 32 }

def set-title [title?: string] {
  let title = $title | default $env.PREFERRED_TITLE? | default "unknown"

  if not ($env | get -i "TMUX" | is-empty ) {
    tmux rename-window $"($title) [nu]"
  } 
}

def title [] {
  let in_repo = (git rev-parse --is-inside-work-tree | complete)

  if $in_repo.exit_code == 0 {
    set-title (git root | path basename)
  } else {
    pwd | path basename | set-title
  }
}

