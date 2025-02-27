$env.config = {
  show_banner: false
}

source ~/.zoxide.nu
source ~/.dotfiles/nushell/atuin.nu
source ~/.dotfiles/nushell/theme.nu

$env.PATH = $env.PATH | append [
  "/opt/homebrew/bin"
  "/opt/homebrew/sbin"
  "/Users/felipesere/bin"
  "/Users/felipesere/.cargo/bin"
  "/Users/felipesere/.local/bin"
  "/Users/felipesere/go/bin"
  "/Users/felipesere/Library/Application Support/JetBrains/Toolbox/scripts"
]

$env.SHELL = "nu"

use ~/.dotfiles/starship/starship.nu

alias nu-open = open
alias open = ^open
alias fg = job unfreeze
alias vim = nvim
alias light = set-theme "light"
alias dark = set-theme "dark"


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

  match $env.TMUX {
    null => {},
    _ => (tmux rename-window $title)
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

