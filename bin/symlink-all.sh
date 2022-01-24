mkdir -p ~/.config/alacritty ~/.config/nvim

ln -sf $HOME/.dotfiles/alacritty/alacritty.yml    $HOME/.config/alacritty/alacritty.yml
ln -sf $HOME/.dotfiles/bat/bat                    $HOME/.bat
ln -sf $HOME/.dotfiles/git/gitconfig              $HOME/.gitconfig
ln -sf $HOME/.dotfiles/git/gitignore              $HOME/.gitignore
ln -sf $HOME/.dotfiles/nvim/init.vim              $HOME/.config/nvim/init.vim
ln -sf $HOME/.dotfiles/nvim/autoload              $HOME/.config/nvim/autoload
ln -sf $HOME/.dotfiles/starship/starship.toml     $HOME/.config/starship.toml
ln -sf $HOME/.dotfiles/tmux/tmux.conf             $HOME/.tmux.conf
ln -sf $HOME/.dotfiles/zsh-minimal/zshrc          $HOME/.zshrc
ln -sf $HOME/.dotfiles/ripgreprc                  $HOME/.ripgreprc
