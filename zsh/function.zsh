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
    local branch
    local status

    # Do nothing if the current directory is not a Git repository.
    if [[ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" != 'true' ]]; then
        return
    fi

    # Do nothing if the current directory is inside `.git`.
    if [[ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'true' ]]; then
        return
    fi

    # Check for uncommitted changes.
    if ! git diff --quiet --ignore-submodules --cached; then
        status=${status}+
    fi

    # Check for unstaged changes.
    if ! git diff-files --quiet --ignore-submodules --; then
        status=${status}x
    fi

    # Check for untracked files.
    if [[ -n "$(git ls-files --others --exclude-standard)" ]]; then
        status=${status}?
    fi

    # Check for stashed files.
    if git rev-parse --verify refs/stash &> /dev/null; then
        status=${status}$
    fi

    if [[ -n "${status}" ]]; then
        status=" ${status}"
    fi

    # Get the branch name or short commit SHA.
    branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null \
    || git rev-parse --short HEAD 2> /dev/null \
    || printf '(unknown)')"

    printf '%s' "${1}${branch}${status}${2}"
}

#############
# LAZY LOAD #
#############

#
## Setup a mock function for lazyload
## Usage:
## 1. Define function "_dalu_lazyload_command_[command name]" that will init the command
## 2. dalu_lazyload_add_command [command name]
#

dalu_lazyload_add_command() {
    eval "$1() { \
            unfunction $1 \
            _dalu_lazyload__command_$1 \
            $1 \$@ \
        }"
}

#
## Setup autocompletion for lazyload
## Usage:
## 1. Define function "_dalu_lazyload_completion_[command name]" that will init the autocompletion
## 2. dalu_lazyload_add_comp [command name]
#

dalu_lazyload_add_completion() {
    local comp_name="_dalu_lazyload__compfunc_$1"
    eval "${comp_name}() { \
        compdef -d $1; \
        _dalu_lazyload_completion_$1; \
    }"
    compdef $comp_name $1
}

# 在命令前插入 sudo
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
    # 光标移动到行末
    zle end-of-line
}

zle -N sudo-command-line
bindkey '\<ESC>\<ESC>' sudo-command-line
