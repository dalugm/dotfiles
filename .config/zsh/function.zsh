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

### proxy

# Enable proxy with optional HTTP and SOCKS ports
proxy_on() {
    local socks_port="${1:-10808}"
    local http_port="${2:-10809}"
    local warn=0

    # Check SOCKS port
    if ! ss -lnt | grep -q ":${socks_port} "; then
        echo "Warning: SOCKS port ${socks_port} does not seem to have a listening service"
        warn=1
    fi

    # Check HTTP port
    if ! ss -lnt | grep -q ":${http_port} "; then
        echo "Warning: HTTP port ${http_port} does not seem to have a listening service"
        warn=1
    fi

    if [ $warn -eq 1 ]; then
        echo "Proxy may not work correctly. Please check your proxy service."
    fi

    export HTTP_PROXY="http://127.0.0.1:${http_port}"
    export HTTPS_PROXY="http://127.0.0.1:${http_port}"
    export ALL_PROXY="socks5://127.0.0.1:${socks_port}"
    export NO_PROXY="localhost,127.0.0.1,::1"

    echo "Proxy enabled (HTTP: ${http_port}, SOCKS: ${socks_port})"
}

# Disable proxy
proxy_off() {
    unset HTTP_PROXY HTTPS_PROXY ALL_PROXY NO_PROXY
    echo "Proxy disabled"
}

# Show current proxy status
proxy_status() {
    echo "HTTP_PROXY  = ${HTTP_PROXY:-<not set>}"
    echo "HTTPS_PROXY = ${HTTPS_PROXY:-<not set>}"
    echo "ALL_PROXY   = ${ALL_PROXY:-<not set>}"
    echo "NO_PROXY    = ${NO_PROXY:-<not set>}"
}

### term

# Set terminal type
term() {
    case "$1" in
        256|xterm-256color)
            export TERM="xterm-256color"
            echo "[OK] TERM set to xterm-256color"
            ;;
        24|xterm-24bit)
            export TERM="xterm-24bit"
            echo "[OK] TERM set to xterm-24bit"
            ;;
        screen-256|s256)
            export TERM="screen-256color"
            echo "[OK] TERM set to screen-256color"
            ;;
        screen-24|s24)
            export TERM="screen-24bit"
            echo "[OK] TERM set to screen-24bit"
            ;;
        *)
            echo "Usage: term {256|24|screen-256|screen-24}"
            echo "  or: term {xterm-256color|xterm-24bit|screen-256color|screen-24bit}"
            echo ""
            echo "Current TERM = ${TERM:-<not set>}"
            return 1
            ;;
    esac
}

# Show current TERM value
term_status() {
    echo "TERM = ${TERM:-<not set>}"
}
