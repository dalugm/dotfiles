#!/usr/bin/env zsh

alias g='git'
alias px='proxychains4'
alias ec='emacsclient -nw --alternate-editor=nano'
alias nv='neovide'
alias nvt='neovide --frame transparent'
command_exists helix && alias hx='helix'

# Proxy
export hostip=$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')
alias all_proxy="export HTTP_PROXY=http://127.0.0.1:10809;export HTTPS_PROXY=http://127.0.0.1:10809;export ALL_PROXY=socks5://127.0.0.1:10800;export NO_PROXY=localhost,127.0.0.1,::1"
alias wsl_all_proxy="export HTTP_PROXY=http://${hostip}:10810;export HTTPS_PROXY=http://${hostip}:10810;export ALL_PROXY=socks5://${hostip}:10810;export NO_PROXY=localhost,127.0.0.1,::1"
alias clean_proxy="export HTTP_PROXY=;export HTTPS_PROXY=;export ALL_PROXY="

# TERM
alias x256_term="export TERM=xterm-256color"
alias x24_term="export TERM=xterm-24bit"
alias s256_term="export TERM=screen-256color"
alias s24_term="export TERM=screen-24bit"

# Colorize the ls output
alias ls="ls --color=auto"

# Use a long listing format
alias ll="ls -ahl"

# Show hidden files only
alias l.="ls -d .*"
