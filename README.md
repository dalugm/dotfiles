<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Backup](#backup)
    - [SHELL](#shell)
        - [BASH](#bash)
            - [My personal bash](#my-personal-bash)
        - [ZSH](#zsh)
            - [My personal zsh](#my-personal-zsh)
            - [oh-my-zsh](#oh-my-zsh)
            - [zinit](#zinit)
    - [HOMEBREW](#homebrew)
    - [GIT](#git)
    - [TERMINAL](#terminal)
    - [misc](#misc)
    - [Acknowledgments](#acknowledgments)
- [LICENSE](#license)

<!-- markdown-toc end -->

# Backup

This repository refers to [How to store dotfiles?](https://www.atlassian.com/git/tutorials/dotfiles)

``` shell
git init --bare $HOME/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc
```

1. The first line creates a folder `~/dotfiles` that will track our files.
2. Then we create an alias config which we will use instead of the regular git when we want to interact with our configuration repository.
3. We set a flag - local to the repository - to hide files we are not explicitly tracking yet. This is so that when you type config status and other commands later, files you are not interested in tracking will not show up as untracked.
4. Also you can add the alias definition by hand to your `.bashrc` or use the the fourth line provided for convenience.

After you've executed the setup any file within the `$HOME` folder can be
versioned with normal commands, replacing git with your newly created `config`
alias, like:

``` shell
config status
config add .vimrc
config commit -m "Add vimrc"
config add .bashrc
config commit -m "Add bashrc"
config push
```

## SHELL

### BASH

#### My personal bash

[bash](bash/README.md)

### ZSH

#### My personal zsh

[zsh](zsh/README.md)

#### oh-my-zsh

    ln -s ~/dotfiles/omz-zshrc ~/.zshrc
    
#### zinit

    ln -s ~/dotfiles/zinit-zshrc ~/.zshrc

## HOMEBREW

[homebrew](homebrew/README.md)

## GIT

    ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
    ln -s ~/dotfiles/git/gitignore ~/.gitignore_global

## TERMINAL

`iTerm2` and `alacritty`

``` shell
# alacritty terminal
ln -s ~/dotfiles/terminal/alacritty.yml ~/.alacritty.yml
```

## misc

[misc](misc/README.md)

## Acknowledgments

Inspiration and code were taken from many sources, including:

- [necolas](https://github.com/necolas/dotfiles)
- [alrra](https://github.com/alrra/dotfiles)
- [isaacs](https://github.com/isaacs/dotfiles)
- [eed3si9n](https://github.com/eed3si9n/dotfiles)
- [b4b4r07](https://github.com/b4b4r07/dotfiles)
- [.tmux](https://github.com/gpakosz/.tmux)
- [ghacks-user.js](https://github.com/ghacksuserjs/ghacks-user.js)
- [The Ultimate Bashrc File GNOME-Look.org](https://gnome-look.org/content/show.php/Ultimate+Bashrc+File?content=129746)
- [Font configuration - ArchWiki](https://wiki.archlinux.org/index.php/font_configuration)

# LICENSE

    (‑●‑●)> dual licensed under the WTFPL v2 license and the MIT license,
            without any warranty.
            Maintained by dalu <mou.tong@qq.com> since 2020-06-03
