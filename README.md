# Backup

Backup for my dotfiles

    brew list > brew.txt
    brew list --cask > brew-cask.txt

    # don't record dependency
    brew leaves > brew.txt

    brew cask list > brew-cask.txt # DEPRECATED since HOMEBREW v2.50

## Install

1. First way

``` shell
brew install $(cat brew.txt)
brew install --cask $(cat brew-cask.txt)

brew cask install $(cat brew-cask.txt) # DEPRECATED since HOMEBREW v2.50
```
Or use `for` function in shell (which is unnecessary since `cat` has already done this):

``` shell
for i in $(cat brew.txt); do;
    brew install "$1";
done

for i in $(cat brew-cask.txt); do;
    brew cask install "$1";
done
```

2. Second way

``` shell
xargs brew install < brew.txt
xargs brew cask install < brew-cask.txt
```
