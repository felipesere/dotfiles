mkdir -p ~/.config/alacritty ~/.config/nvim

ln -f $HOME/.dotfiles/alacritty/alacritty.toml    $HOME/.config/alacritty/alacritty.toml
cp $HOME/.dotfiles/alacritty/alacritty-font-size.toml $HOME/.alacritty-font-size.toml
cp $HOME/.dotfiles/alacritty/alacritty.light.toml $HOME/.alacritty-theme.yml

ln -sf $HOME/.dotfiles/bin/theme.sh           $HOME/bin/theme
ln -sf $HOME/.dotfiles/bin/branch-prune       $HOME/bin/branch-prune
ln -sf $HOME/.dotfiles/bat/bat                $HOME/.bat
ln -sf $HOME/.dotfiles/git/gitconfig          $HOME/.gitconfig
ln -sf $HOME/.dotfiles/git/gitignore          $HOME/.gitignore
ln -sf $HOME/.dotfiles/nvim                   $HOME/.config/nvim
ln -sf $HOME/.dotfiles/starship/starship.toml $HOME/.config/starship.toml
ln -sf $HOME/.dotfiles/tmux/tmux.conf         $HOME/.tmux.conf
ln -sf $HOME/.dotfiles/zsh-minimal/zshrc      $HOME/.zshrc
ln -sf $HOME/.dotfiles/ripgreprc              $HOME/.ripgreprc
ln -sf $HOME/.dotfiles/lazygit.yaml           $HOME/.lazygit.yaml
ln -sf $HOME/.dotfiles/atuin/config.toml      $HOME/.config/atuin/config.toml
ln -sf $HOME/.dotfiles/gh/config.yml          $HOME/.config/gh/config.yml
ln -sf $HOME/.dotfiles/hammerspoon            $HOME/.hammerspoon
