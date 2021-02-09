#!/usr/env/bin bash

# Set personal aliases
# For a full list of active aliases, run `alias`.
#

alias bashconf="nvim ~/.bashrc"
alias zshconf="nvim ~/.zshrc"
alias tmuxconf="nvim ~/.tmux.conf"
alias alaconf="nvim ~/.alacritty.yml"
alias ytdlconf="nvim ~/.config/youtube-dl/config"

alias g='git'
alias ec='emacsclient'
alias tem='TERM=xterm-24bit emacs'
alias vi='vim'
alias nvi='nvim'

# proxy
alias socks5_proxy="export all_proxy=socks5://127.0.0.1:1080; export http_proxy=http://127.0.0.1:1087; export https_proxy=https://127.0.0.1:1087"
alias http_proxy="export all_proxy=http://127.0.0.1:1087; export http_proxy=http://127.0.0.1:1087; export https_proxy=https://127.0.0.1:1087"
alias clean_proxy="export all_proxy=; export http_proxy=; export https_proxy="

# TERM
alias x256_term="export TERM=xterm-256color"
alias x24_term="export TERM=xterm-24bits"
alias s256_term="export TERM=screen-256color"
alias s24_term="export TERM=screen-24bits"
# List directory contents
alias l="ls -ahlG"

# https://stackoverflow.com/questions/3746/whats-in-your-bashrc
alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
