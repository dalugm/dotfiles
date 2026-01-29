#!/usr/bin/env bash

# Add $1 as path to PATH, do not effect PATH if path not exists
add_path() {
    [[ -d "$1" && ":$PATH:" != *":$1:"* ]] && PATH="$1:$PATH"
}

# Like `add_path()`, but put behind PATH
add_path_behind() {
    [[ -d "$1" && ":$PATH:" != *":$1:"* ]] && PATH="$PATH:$1"
}

# Check command whether available
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Create new directories and then enters the last one
mkd() {
    mkdir -p "$@" && cd "$_" || exit 1
}

# Search for text within bash history
greph() {
    command -p grep --color=always -i -- "$*" "${HISTFILE}" | less -RX
}

# Search for text within the current directory
grepd() {
    command -p grep --color=always -ir --exclude-dir={.git,node_modules} -- "$*" "${PWD}" | less -RX
}

# Convert text files with DOS line endings to Unix line endings
crlf2lf() {
    cat "$@" <&0 | sed -e 's/\r$//g'
}

# Convert text files with Unix line endings to DOS line endings
lf2crlf() {
    cat "$@" <&0 | sed -e 's/$/\r/g'
}

### Git

# Execute `git pull` on every directory within the current directory
git_update_all() {
    find . \
         -maxdepth 1 \
         ! -path . \
         -type d \
         -print \
         -execdir git --git-dir={}/.git --work-tree="${PWD}/{}" pull --rebase \;
}

# Print branch name and working tree status for prompt
__git_prompt_info() {
    local git_branch=''
    local git_status=''

    # Do nothing if the current directory is not a Git repository
    if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) != 'true' ]]; then
        return
    fi

    # Do nothing if the current directory is inside `.git`
    if [[ $(git rev-parse --is-inside-git-dir 2>/dev/null) == 'true' ]]; then
        return
    fi

    # Check for uncommitted changes
    if ! git diff --quiet --ignore-submodules --cached; then
        git_status="${git_status}+"
    fi

    # Check for unstaged changes
    if ! git diff-files --quiet --ignore-submodules --; then
        git_status="${git_status}!"
    fi

    # Check for untracked files
    if [[ -n "$(git ls-files --others --exclude-standard)" ]]; then
        git_status="${git_status}?"
    fi

    # Check for stashed files
    if git rev-parse --verify refs/stash &>/dev/null; then
        git_status="${git_status}$"
    fi

    if [[ -n "${git_status}" ]]; then
        git_status=" ${git_status}"
    fi

    # Get the branch name or short commit SHA
    git_branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null ||
        git rev-parse --short HEAD 2>/dev/null ||
        printf '(unknown)')"

    printf "%s" "${1}${git_branch}${git_status}${2}"
}

### Lazy load

## Setup a mock function for lazyload
#
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
                unset -f ${command_name}; \
                _my_lazyload_command_${command_name}; \
                return ${command_name} \"\$@\"; \
        }"
}
