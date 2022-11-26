#!/usr/bin/env zsh

# ${HOME}/.zshrc: executed by zsh(1) for non-login shells.
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# For Performance Debug purpose
export MY_ENABLE_PERFORMANCE_PROFILING="false"

if [[ "${MY_ENABLE_PERFORMANCE_PROFILING:-}" == "true" ]]; then
    zmodload zsh/zprof

    zmodload zsh/datetime
    setopt PROMPT_SUBST
    PS4='+$EPOCHREALTIME %N:%i> '
    rm -rf zsh_profile*
    __my_zsh_profiling_logfile=$(mktemp zsh_profile.XXXXXX)
    echo "Logging to $__my_zsh_profiling_logfile"
    exec 3>&2 2>$__my_zsh_profiling_logfile

    setopt XTRACE
fi

# Path to zsh installation.
# Distribute zshrc into smaller, more specific files
export ZSH=$HOME/.config/zsh

##########
# EXPORT #
##########

# Set the default language
export LANG=en_US.UTF-8

# Set the default collation order as in C.
export LC_COLLATE='C'

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

#
## History
#

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

# 多个 zsh 间分享历史纪录
setopt SHARE_HISTORY

# 如果连续输入的命令相同，历史纪录中只保留一个
setopt HIST_IGNORE_DUPS

# 为历史纪录中的命令添加时间戳
#setopt EXTENDED_HISTORY

# 启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
setopt AUTO_PUSHD

# 相同的历史路径只保留一个
setopt PUSHD_IGNORE_DUPS

# 在命令前添加空格，不将此命令添加到纪录文件中
setopt HIST_IGNORE_SPACE

# End of lines configured by zsh-newuser-install

# Enable ls colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Colors!
export reset='\e[0m'
export gray='\e[30m'
export red='\e[31m'
export bold_red='\e[1;31m'
export green='\e[32m'
export bold_green='\e[1;32m'
export yellow='\e[33m'
export bold_yellow='\e[1;33m'
export blue='\e[34m'
export bold_blue='\e[1;34m'
export purple='\e[35m'
export cyan='\e[36m'
export white='\e[37m'

###########
# ENHANCE #
###########

# ls colors
autoload -U colors && colors

[[ -f $ZSH/completion.zsh ]] && source $ZSH/completion.zsh

#
## Keybinding
#

# [DEFAULT] Use $EDITOR key bindings

# Use EMACS key bindings
bindkey -e

# # Use VIM key bindings
# bindkey -v

# eXecute Editor
autoload -U         edit-command-line
zle      -N         edit-command-line
bindkey  '\C-o'     edit-command-line # VIM style
bindkey  '\C-x\C-e' edit-command-line # EMACS style

# [Ctrl-r] - Search backward incrementally for a specified string.
# The string may begin with ^ to anchor the search to the beginning of the line.
bindkey '^r' history-incremental-search-backward

############
# FUNCTION #
############

# Load `function.zsh` if it exists.
[[ -f $ZSH/function.zsh ]] && source $ZSH/function.zsh

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
[[ -f "$ZSH/alias.zsh" ]] && source "$ZSH/alias.zsh"

##############
# COMPLETION #
##############

# Enable additional programmable completion features.
[[ -d /usr/local/share/zsh-completions ]] && fpath=(/usr/local/share/zsh-completions $fpath)

#######################
# Local Configuration #
#######################

# Load `.zshrc.local` if it exists.
[[ -f "${HOME}/.zshrc.local" ]] && source "${HOME}/.zshrc.local"

######################
# User Configuration #
######################

# Personal PATH
export PATH="$HOME/vendors/build:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"

# launch Emacs from terminal on macOS
if [ -d "/Applications/Emacs.app/Contents/MacOS/bin" ]; then
  export PATH="/Applications/Emacs.app/Contents/MacOS:/Applications/Emacs.app/Contents/MacOS/bin:$PATH"
  alias emacs="Emacs"
fi

## Lisp
# Ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"

## C-family
export PATH="/usr/local/opt/llvm/bin:$PATH"

# .NET SDK tools
export PATH="$PATH:$HOME/.dotnet/tools"

## Rust
export PATH="$PATH:$HOME/.cargo/bin"

## Java
export JAVA_TOOL_OPTIONS="-Duser.language=en \
                          -Duser.region=US \
                          -Dfile.encoding=UTF-8"

# andriod
export PATH="$PATH:$HOME/Library/Android/sdk/cmdline-tools/latest/bin"
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"

## GO
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$PATH"

## Flutter
export PATH="$HOME/flutter/bin:$PATH"
PUB_HOSTED_URL=https://pub.flutter-io.cn
FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

## Node.js

# # N
# export N_PREFIX=$HOME
# export PATH=$N_PREFIX/bin:$PATH

# fnm
export PATH=/home/dalu/.fnm:$PATH
if command -v fnm > /dev/null 2>&1; then
    eval "$(fnm env --use-on-cd)"
fi

# pnpm
export PNPM_HOME="$HOME/.local/lib/pnpm"
export PATH="$PNPM_HOME:$PATH"

## Python
export PYENV_ROOT="${PYENV_ROOT:=${HOME}/.pyenv}"
export PATH="${PYENV_ROOT}/bin:${PATH}"

# Lazyload pyenv
if (( $+commands[pyenv] )) &>/dev/null; then
    export PATH="${PYENV_ROOT}/shims:${PATH}"

    _my_lazyload_command_pyenv() {
        eval "$(command pyenv init -)"
        if [[ -n "${ZSH_PYENV_LAZY_VIRTUALENV}" ]]; then
            eval "$(command pyenv virtualenv-init -)"
        fi
    }

    _my_lazyload_completion_pyenv() {
        source "${PYENV_ROOT}/completions/pyenv.zsh"
    }

    my_lazyload_add_command pyenv
    my_lazyload_add_completion pyenv
fi

## Ruby
export RBENV_ROOT="${RBENV_ROOT:=${HOME}/.rbenv}"
export PATH="${RBENV_ROOT}/bin:${PATH}"

# Lazyload rbenv
if (( $+commands[rbenv] )) &>/dev/null; then
    export PATH="${RBENV_ROOT}/shims:${PATH}"

    _my_lazyload_command_rbenv() {
        eval "$(rbenv init -)"
    }

    _my_lazyload_completion_rbenv() {
        source "${RBENV_ROOT}/completions/rbenv.zsh"
    }

    my_lazyload_add_command rbenv
    my_lazyload_add_completion rbenv
fi

## HOMEBREW

export PATH="/usr/local/sbin:$PATH"

# WSL
[ -d /home/linuxbrew/.linuxbrew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# 关闭 homebrew 自动更新
export HOMEBREW_NO_AUTO_UPDATE=true

# N 天后清除下载的安装包
export HOMEBREW_CLEANUP_MAX_AGE_DAYS=30

##########
# PROMPT #
##########

setopt PROMPT_SUBST

autoload -Uz promptinit
promptinit

# # You can also use builtin vcs_info instead of themes
# # https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
# # https://stackoverflow.com/questions/1128496/to-get-a-prompt-which-indicates-git-branch-in-zsh
# autoload -Uz vcs_info

[[ -f $ZSH/random-theme.zsh ]] && source $ZSH/random-theme.zsh

PROMPT_RANDOM_CANDIDATES=(
    default
    lambda
    mh
    minimal
    ys
)

# Make new shells get the history list from all previous shells.
if [[ ! "${PROMPT_COMMAND}" =~ 'history -a;' ]]; then
    export PROMPT_COMMAND="history -a; ${PROMPT_COMMAND}"
fi

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
elif [[ -f /usr/share/global/gtags/gtags.conf ]]; then
    export GTAGSCONF=/usr/share/global/gtags/gtags.conf
    export GTAGSLABEL=native-pygments
elif [[ -f /etc/gtags/gtags.conf ]]; then
    export GTAGSCONF=/etc/gtags/gtags.conf
    export GTAGSLABEL=native-pygments
fi

[ -f $ZSH/plugins/colorman.sh ] && source $ZSH/plugins/colorman.sh

# Lazyload thefuck
if (( $+commands[thefuck] )) &>/dev/null; then
    _my_lazyload_command_fuck() {
        eval $(thefuck --alias)
    }

    my_lazyload_add_command fuck
fi

# zsh-completions
[ -d $ZSH/plugins/zsh-completions ] && source $ZSH/plugins/zsh-completions/zsh-completions.plugin.zsh

# zsh-autosuggestions
[ -d $ZSH/plugins/zsh-autosuggestions ] && source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting
[ -d $ZSH/plugins/zsh-syntax-highlighting ] && source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# rust tools
if command -v zoxide > /dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

########
# PATH #
########

# remove duplicate PATH
# https://unix.stackexchange.com/questions/40749/remove-duplicate-path-entries-with-awk-command
if [ -n "$PATH" ]; then
    old_PATH=$PATH:; PATH=
    while [ -n "$old_PATH" ]; do
        x=${old_PATH%%:*}       # the first remaining entry
        case $PATH: in
            *:"$x":*) ;;        # already there
            *) PATH=$PATH:$x;;  # not there yet
        esac
        old_PATH=${old_PATH#*:}
    done
    PATH=${PATH#:}
    unset old_PATH x
fi

export PATH

# add the manpath
export MANPATH="/usr/local/share/man:${MANPATH}"

#########
# DEBUG #
#########

if [[ "${MY_ENABLE_PERFORMANCE_PROFILING:-}" == "true" ]]; then
    unsetopt XTRACE
    exec 2>&3 3>&-

    parse_zsh_profiling() {
        typeset -a lines
        typeset -i prev_time=0
        typeset prev_command

        while read line; do
            if [[ $line =~ '^.*\+([0-9]{10})\.([0-9]{6})[0-9]* (.+)' ]]; then
                integer this_time=$match[1]$match[2]

                if [[ $prev_time -gt 0 ]]; then
                    time_difference=$(( $this_time - $prev_time ))
                    lines+="$time_difference $prev_command"
                fi

                prev_time=$this_time

                local this_command=$match[3]
                if [[ ${#this_command} -le 80 ]]; then
                    prev_command=$this_command
                else
                    prev_command="${this_command:0:77}..."
                fi
            fi
        done < ${1:-/dev/stdin}

        print -l ${(@On)lines}
    }

    zprof() {
        unfunction zprof

        parse_zsh_profiling $__my_zsh_profiling_logfile | head -n 30

        echo ""
        echo "========================================"
        echo ""

        zprof $@
    }
fi
