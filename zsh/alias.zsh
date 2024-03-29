#!/usr/bin/env zsh

# Set personal aliases.
# For a full list of active aliases, run `alias`.
#

alias g='git'
alias px='proxychains4'
alias ec='emacsclient -nw --alternate-editor=nano'
alias tem='TERM=xterm-24bit emacs'
alias vi='vim'
alias nvi='nvim'

# Proxy.
export hostip=$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')
alias all_proxy="export http_proxy=http://127.0.0.1:1080;export https_proxy=http://127.0.0.1:1080;export all_proxy=socks5://127.0.0.1:1080"
alias wsl_all_proxy="export http_proxy=http://${hostip}:10810;export https_proxy=http://${hostip}:10810;export all_proxy=socks5://${hostip}:10810"
alias clean_proxy="export http_proxy=;export https_proxy=;export all_proxy="

# TERM.
alias x256_term="export TERM=xterm-256color"
alias x24_term="export TERM=xterm-24bit"
alias s256_term="export TERM=screen-256color"
alias s24_term="export TERM=screen-24bit"

# List directory contents.
alias l="ls -ahlG"

# https://stackoverflow.com/questions/3746/whats-in-your-bashrc
alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# https://www.atlassian.com/git/tutorials/dotfiles
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
