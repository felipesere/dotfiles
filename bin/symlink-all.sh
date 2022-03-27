mkdir -p ~/.config/alacritty ~/.config/nvim

ln -f $HOME/.dotfiles/alacritty/alacritty.yml    $HOME/.config/alacritty/alacritty.yml
cp $HOME/.dotfiles/alacritty/alacritty-font-size.yml $HOME/.alacritty-font-size.yml

ln -sf $HOME/.dotfiles/bat/bat                    $HOME/.bat
ln -sf $HOME/.dotfiles/git/gitconfig              $HOME/.gitconfig
ln -sf $HOME/.dotfiles/git/gitignore              $HOME/.gitignore
ln -sf $HOME/.dotfiles/nvim/init.vim              $HOME/.config/nvim/init.vim
ln -sf $HOME/.dotfiles/nvim/autoload              $HOME/.config/nvim/autoload
ln -sf $HOME/.dotfiles/nvim/lua                   $HOME/.config/nvim/lua
ln -sf $HOME/.dotfiles/starship/starship.toml     $HOME/.config/starship.toml
ln -sf $HOME/.dotfiles/tmux/tmux.conf             $HOME/.tmux.conf
ln -sf $HOME/.dotfiles/zsh-minimal/zshrc          $HOME/.zshrc
ln -sf $HOME/.dotfiles/ripgreprc                  $HOME/.ripgreprc
ln -sf $HOME/.dotfiles/lazygit.yaml               $HOME/.lazygit.yaml
ln -sf $HOME/.dotfiles/atuin/config.toml          $HOME/.config/atuin/config.toml
