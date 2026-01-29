#!/usr/bin/env zsh

# Add $1 as path to PATH, do not effect PATH if path not exists
add_path() {
    [[ -d "$1" && ":$PATH:" != *":$1:"* ]] && PATH="$1:$PATH"
}

# Like `add_path()`, but put behind PATH
add_path_behind() {
    [[ -d "$1" && ":$PATH:" != *":$1:"* ]] && PATH="$PATH:$1"
}

# Check command whether exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Create new directories and then enters the last one
mkd() {
    mkdir -p "$@" && cd "$_" || exit 1
}

# Search for text within bash history
greph() {
    command -p grep --color=always -i -- "$*" "$HISTFILE" | less -RX
}

# Search for text within the current directory
grepd() {
    command -p grep --color=always -ir --exclude-dir={.git,node_modules} -- "$*" "$PWD" | less -RX
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
                    unfunction ${command_name}; \
                    _my_lazyload_command_${command_name}; \
                    return ${command_name} \"\$@\"; \
    }"
}

## Setup auto completion for lazyload
#
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

### Misc

# Insert sudo before command
sudo_command_line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
    zle end-of-line
}

zle -N sudo_command_line
bindkey '\e\e' sudo_command_line
