# Backup

backup for my dotfiles

``` sh
brew list > brew.txt; brew cask list > brew-cask.txt
pip3 freeze > pip3.txt
```

## Install by `brew` and `brew-cask` files

```sh
brew install $(cat brew.txt)
brew cask install $(cat brew-cask.txt)
```

## Install python packages

```sh
pip3 install -r pip3.txt
```

## Usage

### fzf

use `j/<C-n>` and `k/<C-p>` to `down` and `up`.

use `<C-j>` and `<C-k>` to make preview `down` and `up`.
