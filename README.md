# Backup

backup for my dotfiles

``` sh
brew list > brew.txt; brew cask list > brew-cask.txt
```

## Install by `brew` and `brew-cask` files

```sh
    brew install $(cat brew.txt)
    brew cask install $(cat brew-cask.txt)
```

## Install python lib

```sh
    pip3 install -r pip3.txt
```
