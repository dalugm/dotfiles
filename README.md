# Backup

backup for my dotfiles

    brew list > brew.txt; brew cask list > brew-cask.txt

## Install by `brew` and `brew-cask` files

    brew install $(cat brew.txt)
    brew cask install $(cat brew-cask.txt)
