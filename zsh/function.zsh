#!/usr/env/bin bash

#
## Lists all defined functions.
#
list_functions() {
    declare -F | grep -v '\-f _'
}

#
## Creates new directories and then enters the last one.
#
mkd() {
    mkdir -p "$@" && cd "$_" || exit 1
}

#
## Searches for text within bash history.
#
qh() {
    command -p grep --color=always -i -- "$*" "${HISTFILE}" | less -RX
}

#
## Searches for text within the current directory.
#
qt() {
    command -p grep --color=always -ir --exclude-dir={.git,node_modules} -- "$*" "${PWD}" | less -RX
}

#
## Converts text files with DOS line endings to Unix line endings.
#
crlf2lf() {
    cat "$@" <&0 | sed -e 's/\r$//g'
}

#
## Converts text files with Unix line endings to DOS line endings.
#
lf2crlf() {
    cat "$@" <&0 | sed -e 's/$/\r/g'
}

#######
# GIT #
#######

#
## Execute `git pull` on every directory within the current directory.
#
git-update-all() {
    find . \
         -maxdepth 1 \
         ! -path . \
         -type d \
         -print \
         -execdir git --git-dir={}/.git --work-tree="${PWD}/{}" pull --rebase \;
}

#
## Prints Git branch name and working tree status for prompt.
#
git_prompt_info() {
    local git_branch=''
    local git_status=''

    # Do nothing if the current directory is not a Git repository.
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
        return
    fi

    # Do nothing if the current directory is inside `.git`.
    if [[ $(git rev-parse --is-inside-git-dir 2> /dev/null) == 'true' ]]; then
        return
    fi

    # Check for uncommitted changes.
    if ! git diff --quiet --ignore-submodules --cached; then
        git_status="${git_status}+"
    fi

    # Check for unstaged changes.
    if ! git diff-files --quiet --ignore-submodules --; then
        git_status="${git_status}!"
    fi

    # Check for untracked files.
    if [[ -n "$(git ls-files --others --exclude-standard)" ]]; then
        git_status="${git_status}?"
    fi

    # Check for stashed files.
    if git rev-parse --verify refs/stash &> /dev/null; then
        git_status="${git_status}$"
    fi

    if [[ -n "${git_status}" ]]; then
        git_status=" ${git_status}"
    fi

    # Get the branch name or short commit SHA.
    git_branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null \
    || git rev-parse --short HEAD 2> /dev/null \
    || printf '(unknown)')"

    printf "%s" "${1}${git_branch}${git_status}${2}"
}

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
    vcs_info
    if [ -n "$vcs_info_msg_0_" ]; then
        echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
    fi
}

#############
# LAZY LOAD #
#############

## @see https://best33.com/283.moe
## 基本原理：
# 声明一个占位函数，当执行这个函数时完成对真实命令的初始化、并移除命令占位。

## Setup a mock function for lazyload
## Principle
# 1. remove original function
# 2. lazyload to init function
# 3. continue executing function
## Usage:
# 1. Define function "_my_lazyload__command_[command name]" that will init the command
# 2. my_lazyload_add_command [command name]
my_lazyload_add_command() {
    local command_name=$1
    eval "${command_name}() { \
        unfunction ${command_name}; \
        _my_lazyload_command_${command_name}; \
        return ${command_name} \"\$@\"; \
        }"
}

## Setup auto completion for lazyload
## Principle
# 1. remove original function's comp
# 2. lazyload function's comp
## Usage:
# 1. Define function "_my_lazyload_completion_[command name]" that will init the completion
# 2. my_lazyload_add_completion [command name]
my_lazyload_add_completion() {
    local completion_name="_my_lazyload_completion_$1"
    eval "${completion_name}() { \
        compdef -d $1; \
        _my_lazyload_completion_$1; \
    }"
    compdef $completion_name $1
}

########
# MISC #
########

# 在命令前插入 sudo
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
    # 光标移动到行末
    zle end-of-line
}

zle -N sudo-command-line
bindkey '\e\e' sudo-command-line
