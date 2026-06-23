#!/usr/bin/env bash

alias g='git'
command_exists helix && alias hx='helix'

# Colorize the ls output (BSD ls uses -G, GNU ls uses --color=auto)
if ls --color=auto /dev/null >/dev/null 2>&1; then
    alias ls="ls --color=auto"
elif ls -G /dev/null >/dev/null 2>&1; then
    alias ls="ls -G"
fi

# Use a long listing format
alias ll="ls -ahl"

# Show hidden files only
alias l.="ls -d .*"
