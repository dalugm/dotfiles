#!/usr/env/bin bash
# Clean, simple, compatible and meaningful.
# Tested on Linux, Unix and Windows under ANSI colors.
# It is recommended to use with a dark background.
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.
#
# Based on ys-theme, 18 September 2020

#
# Prints Git branch name and working tree status for prompt.
#
prompt_git() {
    local branch=''
    local status=''

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
        status="${status}+"
    fi
    # Check for unstaged changes.
    if ! git diff-files --quiet --ignore-submodules --; then
        status="${status}x"
    fi
    # Check for untracked files.
    if [[ -n "$(git ls-files --others --exclude-standard)" ]]; then
        status="${status}?"
    fi
    # Check for stashed files.
    if git rev-parse --verify refs/stash &> /dev/null; then
        status="${status}$"
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

#
# Sets the prompt statement variables.
# shellcheck disable=SC2034
#
set_prompts() {
    local reset='\[\033[0m\]'
    local gray='\[\033[30m\]'
    local red='\[\033[31m\]'
    local bold_red='\[\033[1;31m\]'
    local green='\[\033[32m\]'
    local yellow='\[\033[33m\]'
    local bold_yellow='\[\033[1;33m\]'
    local blue='\[\033[34m\]'
    local bold_blue='\[\033[1;34m\]'
    local purple='\[\033[35m\]'
    local cyan='\[\033[36m\]'
    local white='\[\033[37m\]'

    # Set the terminal title.
    #   user@hostname: ~
    PS1='\[\033]0;\u@\h: \w\007\]'

    # Set the default interactive prompt.
    # # user @ hostname in ~ on git:master ox?$
    # $ ...
    PS1+=$'\n'
    PS1+="${bold_blue}# ${reset}${cyan}\u ${reset}@ ${green}\h "
    PS1+="${gray}in ${bold_yellow}\w "
    PS1+="${reset}on git:\$(prompt_git ' ${purple}' '')"
    PS1+=$'\n'
    PS1+="${bold_red}\\$ "
    PS1+="${reset}"

    # Set the continuation interactive prompt.
    # -> ...
    PS2="${gray}-> "
    PS2+="${reset}"

    export PS1
    export PS2
}

set_prompts
unset -f set_prompts
