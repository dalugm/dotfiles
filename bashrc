#!/usr/bin/env bash

# ${HOME}/.bashrc: executed by bash(1) for non-login shells.
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Path to bash installation.
# Distribute bashrc into smaller, more specific files
export BASH=$HOME/.config/bash

##########
# export #
##########

# Set the default language
export LANG=en_US.UTF-8

# Set the default collation order as in C.
export LC_COLLATE='C'

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
# export TERM=xterm-24bits
# export TERM=xterm-256color

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nvim'
else
    export EDITOR='nvim'
fi

###########
# PLUGINS #
###########

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

########
# Path #
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

    # Prepend directories to `PATH`.
    for index in ${!prepend_dirs[*]}; do
        if test_path "${prepend_dirs[$index]}"; then
            PATH="${prepend_dirs[$index]}:${PATH}"
        fi
    done

    # Append directories to `PATH`.
    for index in ${!append_dirs[*]}; do
        if test_path "${append_dirs[$index]}"; then
            PATH="${PATH}:${append_dirs[$index]}"
        fi
    done

    export PATH
}

set_path
unset -f test_path
unset -f set_path

# add the manpath
export MANPATH="/usr/local/share/man:$MANPATH"

# ----------------------------------------------------------
# Prompt
# ----------------------------------------------------------

if [[ -f $BASH/prompt.sh ]]; then
    source "$BASH/prompt.sh"
fi

# Set the number of trailing directory components to retain in prompt.
export PROMPT_DIRTRIM=3

# Make new shells get the history list from all previous shells.
if [[ ! "${PROMPT_COMMAND}" =~ 'history -a;' ]]; then
    export PROMPT_COMMAND="history -a; ${PROMPT_COMMAND}"
fi

# ----------------------------------------------------------
# Alias
# ----------------------------------------------------------

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

# Load `.bash_aliases` if it exists.
if [[ -f "$BASH/alias.sh" ]]; then
    source "$BASH/alias.sh"
fi

# ----------------------------------------------------------
# Functions
# ----------------------------------------------------------

# Load `function.sh` if it exists.
if [[ -f $BASH/function.sh ]]; then
    source $BASH/function.sh
fi

# ----------------------------------------------------------
# Completion
# ----------------------------------------------------------

# Enable programmable completion features.
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash_completion ]]; then
    source /etc/bash_completion
fi

# ----------------------------------------------------------
# Local Configuration
# ----------------------------------------------------------

# Load `.bashrc.local` if it exists.
if [[ -f "${HOME}/.bashrc.local" ]]; then
    source "${HOME}/.bashrc.local"
fi
