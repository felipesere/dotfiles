$env.config = {
  show_banner: false
}

use ~/.dotfiles/starship/starship.nu

alias nvim = vim

def --env dots [] {
  cd ~/.dotfiles
}

def font_size [size] {
  open ~/.alacritty-font-size.toml | update font.size $size | to toml | save -f ~/.alacritty-font-size.toml
}

def laptop [] { font_size 16 }
def normal [] { font_size 24 }
def presentatation [] { font_size 32 }

