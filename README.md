# Backup

Backup for my dotfiles

    brew list > brew.txt
    brew list --cask > brew-cask.txt

    brew cask list > brew-cask.txt (DEPRECATED since HOMEBREW v2.50)

## Install by `brew` and `brew-cask` files

    brew install $(cat brew.txt)
    brew install --cask $(cat brew-cask.txt)

    brew cask install $(cat brew-cask.txt) (DEPRECATED since HOMEBREW v2.50)
