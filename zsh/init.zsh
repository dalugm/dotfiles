#!/usr/bin/env zsh

# ${HOME}/.zshrc: executed by zsh(1) for non-login shells.
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Path to zsh installation.
# Distribute zshrc into smaller, more specific files
export ZSH=$HOME/.config/zsh

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} r:|[._-]=** r:|=**' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=0
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/Users/mou/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
export HISTFILE=~/.zsh_history

# The maximum number of lines to remember in the command history.
export HISTSIZE=1000

# The maximum number of lines to save in the history file.
export HISTFILESIZE=1000

# The maximum number of history events to save in the history file.
export SAVEHIST=1000

# Disable saving lines that begin with a space or match the last history line to
# the history list.
export HISTCONTROL='ignoreboth'

# Disable saving the following commands to the history list.
export HISTIGNORE='&:bg:fg'

# Enable time stamp for `history` builtin.
export HISTTIMEFORMAT='%F %T '
# End of lines configured by zsh-newuser-install

##########
# export #
##########

# Set the default language
export LANG=en_US.UTF-8

# Set the default collation order as in C.
export LC_COLLATE='C'

# Set TERM value
# export TERM=xterm-24bits
# export TERM=xterm-256color

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nvim'
else
    export EDITOR='nvim'
fi

###########
# ENHANCE #
###########

source $ZSH/lib/git.zsh
source $ZSH/lib/completion.zsh
source $ZSH/lib/key-bindings.zsh
source $ZSH/lib/theme-and-appearance.zsh

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# eXecute Editor
autoload -U   edit-command-line
zle      -N   edit-command-line
bindkey  '^o' edit-command-line

########
# PATH #
########

#
# Tests whether a directory can be added to `PATH`.
#
test_path() {
    [[ -d "${1}" && ":${PATH}:" != *":${1}:"* ]]
}

#
# Sets the `PATH` environment variable.
#
set_path() {
    # Define the directories to be prepended to `PATH`.
    local -a prepend_dirs=(
        /usr/local/bin
    )

    # Define the directories to be appended to `PATH`.
    local -a append_dirs=(
        /usr/bin
        "${HOME}/bin"
        "${HOME}/.local/bin"
    )

    # # Prepend directories to `PATH`.
    # for index in ${!prepend_dirs[*]}; do
    #     if test_path "${prepend_dirs[$index]}"; then
    #         PATH="${prepend_dirs[$index]}:${PATH}"
    #     fi
    #     echo "HERE"
    # done

    # # Append directories to `PATH`.
    # for index in ${!append_dirs[*]}; do
    #     if test_path "${append_dirs[$index]}"; then
    #         PATH="${PATH}:${append_dirs[$index]}"
    #     fi
    # done

    export PATH
}

set_path
unset -f test_path
unset -f set_path

# add the manpath
export MANPATH="/usr/local/share/man:${MANPATH}"

##########
# PROMPT #
##########

source ~/.config/zsh/prompt.zsh

# Make new shells get the history list from all previous shells.
if [[ ! "${PROMPT_COMMAND}" =~ 'history -a;' ]]; then
    export PROMPT_COMMAND="history -a; ${PROMPT_COMMAND}"
fi

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

# Load `alias.zsh` if it exists.
if [[ -f "$ZSH/alias.sh" ]]; then
    source "$ZSH/alias.sh"
fi

############################################################
#                      => export <=                        #
############################################################

# Personal PATH
export PATH="$HOME/tools/build:$PATH"

# GO
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$PATH"

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# Ruby
export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

if command -v rbenv 1>/dev/null 2>&1; then
    eval "$(rbenv init -)"
fi

# HOMEBREW
# 关闭 homebrew 自动更新
export HOMEBREW_NO_AUTO_UPDATE=true
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
export HOMEBREW_CLEANUP_MAX_AGE_DAYS=30

# ----------------------------------------------------------
# Functions
# ----------------------------------------------------------

# Load `function.sh` if it exists.
if [[ -f $ZSH/function.sh ]]; then
    source $ZSH/function.sh
fi

# ----------------------------------------------------------
# Completion
# ----------------------------------------------------------

# Enable programmable completion features.
if [[ -f /usr/share/zsh-completion/zsh_completion ]]; then
    source /usr/share/zsh-completion/zsh_completion
elif [[ -f /usr/local/etc/zsh_completion.d ]]; then
    source /usr/local/etc/zsh_completion.d
elif [[ -f /etc/zsh_completion ]]; then
    source /etc/zsh_completion
fi

# ----------------------------------------------------------
# Local Configuration
# ----------------------------------------------------------

# Load `.zshrc.local` if it exists.
if [[ -f "${HOME}/.zshrc.local" ]]; then
    source "${HOME}/.zshrc.local"
fi

###########
# PLUGINS #
###########

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
