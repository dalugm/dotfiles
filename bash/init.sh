#!/usr/bin/env bash

# ${HOME}/.bashrc: executed by bash(1) for non-login shells.
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Path to bash installation.
# Distribute bashrc into smaller, more specific files
export BASH=$HOME/.config/bash

##########
# EXPORT #
##########

# Set the default language
export LANG=en_US.UTF-8

# Set the default collation order as in C.
export LC_COLLATE='C'

#
## History
#

# cmd history save file
export HISTFILE=~/.bash_history

# Set the maximum number of lines to save in the history file.
export HISTFILESIZE=1000

# Set the maximum number of lines to remember in the command history.
export HISTSIZE=1000

# Disable saving lines that begin with a space or match the last history line to
# the history list.
export HISTCONTROL='ignoreboth'

# Disable saving the following commands to the history list.
export HISTIGNORE='&:bg:fg'

# Enable time stamp for `history` builtin.
export HISTTIMEFORMAT='%F %T '

# Set TERM value
# export TERM=xterm-24bit
# export TERM=xterm-256color

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
    export ALTERNATE_EDITOR='nano'
else
    export EDITOR='nano'
    export ALTERNATE_EDITOR='vim'
fi


# Colors!
export reset='\033[0m'
export gray='\033[30m'
export red='\033[31m'
export bold_red='\033[1;31m'
export green='\033[32m'
export bold_green='\033[1;32m'
export yellow='\033[33m'
export bold_yellow='\033[1;33m'
export blue='\033[34m'
export bold_blue='\033[1;34m'
export purple='\033[35m'
export cyan='\033[36m'
export white='\033[37m'

############
# FUNCTION #
############

# Load `function.sh` if it exists.
[[ -f "$BASH"/function.sh ]] && source "$BASH"/function.sh

#########
# ALIAS #
#########

# Enable color support.
if [[ -x /usr/bin/dircolors ]]; then
    if [[ -r "${HOME}/.dircolors" ]]; then
        eval "$(dircolors -b "${HOME}/.dircolors")"
    else
        eval "$(dircolors -b)"
    fi
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Load `alias.sh` if it exists.
[[ -f "$BASH/alias.sh" ]] && source "$BASH/alias.sh"

##############
# COMPLETION #
##############

#######################
# Local Configuration #
#######################

# Load `.bashrc.local` if it exists.
[[ -f "${HOME}/.bashrc.local" ]] && source "${HOME}/.bashrc.local"

##########
# PROMPT #
##########

PS1='[\u@\h \W]\$ '

# [[ -f $BASH/random-theme.sh ]] && source "$BASH/random-theme.sh"

# PROMPT_RANDOM_CANDIDATES=(
#     default
#     lambda
#     mh
#     minimal
#     ys
# )

######################
# User Configuration #
######################

# Personal PATH.
export PATH="$HOME/vendors/build:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"

# Launch Emacs from terminal on macOS.
if [ -d "/Applications/Emacs.app/Contents/MacOS/bin" ]; then
  export PATH="/Applications/Emacs.app/Contents/MacOS:/Applications/Emacs.app/Contents/MacOS/bin:$PATH"
  alias emacs="Emacs"
fi

# C.
export PATH="/usr/local/opt/llvm/bin:$PATH"

# Rust.
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# DOTNET.
export PATH="$HOME/.dotnet/tools:$PATH"

# Java.
export JAVA_TOOL_OPTIONS="-Duser.language=en -Duser.region=US -Dfile.encoding=UTF-8"

# Andriod.
export PATH="$PATH:$HOME/Library/Android/sdk/cmdline-tools/latest/bin"
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"

# GO.
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Flutter.
export PATH="$HOME/flutter/bin:$PATH"
export PATH="$HOME/.pub-cache/bin:$PATH"
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

# Rtx.
if command -v rtx > /dev/null 2>&1; then
    eval "$(rtx activate zsh)"
elif [[ -d "$HOME/.local/share/rtx/bin" ]]; then
    export PATH="$HOME/.local/share/rtx/bin:$PATH"
    eval "$(rtx activate zsh)"
fi

# Haskell.
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# Erlang.
export KERL_BUILD_DOCS="yes"
if command -v javac > /dev/null 2>&1; then
    export KERL_CONFIGURE_OPTIONS="--disable-debug"
else
    # Skip java dependency if Java is unavailable.
    export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac"
fi

if command -v brew > /dev/null 2>&1; then
    export KERL_CONFIGURE_OPTIONS="--with-ssl=$(brew --prefix openssl@1.1)"
fi

# Ruby.
if command -v brew > /dev/null 2>&1; then
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3)"
fi

## Node.js

# pnpm
export PNPM_HOME="$HOME/.local/lib/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac

## HOMEBREW.

export HOMEBREW_NO_AUTO_UPDATE=true
export HOMEBREW_CLEANUP_MAX_AGE_DAYS=30
export PATH="/usr/local/sbin:$PATH"

###########
# PLUGINS #
###########

# GTAGS
if [[ -f $HOME/.globalrc ]]; then
    export GTAGSCONF=$HOME/.globalrc
    export GTAGSLABEL=native-pygments
elif [[ -f /usr/local/share/gtags/gtags.conf ]]; then
    export GTAGSCONF=/usr/local/share/gtags/gtags.conf
    export GTAGSLABEL=native-pygments
fi

[ -f "$BASH"/plugins/colorman.sh ] && source "$BASH"/plugins/colorman.sh

# Lazyload thefuck
if (( "$+commands[thefuck]" )) &>/dev/null; then
    _my_lazyload_command_fuck() {
        eval "$(thefuck --alias)"
    }

    my_lazyload_add_command fuck
fi

# rust tools
if command -v zoxide > /dev/null 2>&1; then
    eval "$(zoxide init bash)"
fi

########
# PATH #
########

# remove duplicate PATH
# https://unix.stackexchange.com/questions/40749/remove-duplicate-path-entries-with-awk-command
if [ -n "$PATH" ]; then
    old_PATH=$PATH:; PATH=
    while [ -n "$old_PATH" ]; do
        x=${old_PATH%%:*}
        case $PATH: in
            *:"$x":*) ;;
            *) PATH=$PATH:$x;;
        esac
        old_PATH=${old_PATH#*:}
    done
    PATH=${PATH#:}
    unset old_PATH x
fi

export PATH
