#!/usr/bin/env bash

# ${HOME}/.bashrc: executed by bash(1) for non-login shells.
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

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
    export ALTERNATE_EDITOR='emacsclient'
else
    export EDITOR='emacsclient'
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


########
# PATH #
########

#
## Tests whether a directory can be added to `PATH`.
#
test_path() {
    [[ -d "${1}" && ":${PATH}:" != *":${1}:"* ]]
}

#
## Sets the `PATH` environment variable.
#
set_path() {
    # Define the directories to be prepended to `PATH`.
    local -a prepend_dirs=(
        /usr/local/bin
        /usr/local/sbin
    )

    # Define the directories to be appended to `PATH`.
    local -a append_dirs=(
        /usr/bin
        "${HOME}/bin"
        "${HOME}/.local/bin"
        "${HOME}/tools/build"
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

# add the manpath
export MANPATH="/usr/local/share/man:${MANPATH}"

############
# FUNCTION #
############

# Load `function.sh` if it exists.
[[ -f $BASH/function.sh ]] && source $BASH/function.sh

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

[[ -f $BASH/random-theme.sh ]] && source "$BASH/random-theme.sh"

PROMPT_RANDOM_CANDIDATES=(
    default
    lambda
    mh
    minimal
    ys
)

######################
# User Configuration #
######################

# Personal PATH
export PATH="$HOME/tools/build:$PATH"

## C-family
export PATH="/usr/local/opt/llvm/bin:$PATH"

# Set the number of trailing directory components to retain in prompt.
export PROMPT_DIRTRIM=3

# Make new shells get the history list from all previous shells.
if [[ ! "${PROMPT_COMMAND}" =~ 'history -a;' ]]; then
    export PROMPT_COMMAND="history -a; ${PROMPT_COMMAND}"
fi

###########
# PLUGINS #
###########

# GTAGS
[ -f /usr/local/share/gtags/gtags.conf ] &&
    export GTAGSCONF=/usr/local/share/gtags/gtags.conf &&
    export GTAGSLABEL=native-pygments

[ -f $BASH/plugins/colorman.sh ] && source $BASH/plugins/colorman.sh

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Set fzf installation directory path
export FZF_BASE=/usr/local/opt/fzf/install

# Set fzf interactive interface
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse \
    --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500' \
    --bind 'ctrl-n:down,ctrl-p:up,ctrl-j:preview-down,ctrl-k:preview-up'"

# Set default fzf command style
# Use fd instead of ripgrep
# https://www.reddit.com/r/linux4noobs/comments/egb644/fzf_newcomer_fd_or_ripgrep/
export FZF_DEFAULT_COMMAND="fd --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build} --hidden --type file"

# Search files cwd
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Search directory from HOME
export FZF_ALT_C_COMMAND="fd -t d . $HOME"

# z.lua
[ -d $BASH/plugins/z.lua ] && eval "$(lua $BASH/plugins/z.lua/z.lua --init bash)"

# Lazyload thefuck
if (( $+commands[thefuck] )) &>/dev/null; then
    _my_lazyload_command_fuck() {
        eval $(thefuck --alias)
    }

    my_lazyload_add_command fuck
fi
