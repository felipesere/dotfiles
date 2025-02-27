def set-theme [theme: string] {
  if $theme not-in ["light", "dark"] {
        error make {
            msg: $"Invalid theme: ($theme). Theme must be either 'light' or 'dark'"
            label: {
                text: "Invalid theme value"
                span: (metadata $theme).span
            }
        }
  }

  # Alacritty
  ^ln -sf $"($env.HOME)/.dotfiles/alacritty/alacritty.($theme).toml" $"($env.HOME)/.alacritty.theme.toml"
  touch $"($env.HOME)/.config/alacritty/alacritty.toml"

  ## Tmux
  if not ( $env | get -i "TMUX" | is-empty ) {
    ^tmux source-file $"($env.HOME)/.dotfiles/tmux/($theme).tmux"
  }

  ## Delta
  ^sd '^features = .*' $"features = ($theme)" $"($env.HOME)/.dotfiles/git/gitconfig"

  ## Vim
  $theme | save -f ~/.theme

  ## Bat
  let bat_theme = if $theme == "light" {
    "Monokai Extended Light"
  } else {
    "Nord"
  }
  ^sd -- '^--theme.*' $'--theme="($bat_theme)"' $"($env.HOME)/.dotfiles/bat/bat"

  ## System
  ^osascript -e $'tell app "System Events" to tell appearance preferences to set dark mode to ($theme == "dark")'
}
