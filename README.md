# My dotfiles 

### Setup

- [ ] Copy ssh keys from old computer to $HOME/.ssh

- [ ] Install Homebrew
```sh
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

- [ ] Install latest git
```sh
brew install git
```

- [ ] Clone dotfiles
```sh
git clone git@github.com:felipesere/dotfiles.git $HOME/.dotfiles
```

- [ ] Install brew deps
```sh
brew bundle --no-lock --cleanup --file $HOME./dotfiles/Brewfile
```

- [ ] Symlink dotfiles
```sh
$HOME/.dotfiles/bin/symlink-all.sh
```
