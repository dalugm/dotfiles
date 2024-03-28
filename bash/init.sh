#!/usr/bin/env bash

# ${HOME}/.bashrc: executed by bash(1) for non-login shells.
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Path to bash installation.
# Distribute bashrc into smaller, more specific files
export BASH=$HOME/.config/bash

### Basic.

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

### History.

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

### Better defaults.

[[ -f "$BASH/function.sh" ]] && . "$BASH/function.sh"
[[ -f "$BASH/alias.sh" ]] && . "$BASH/alias.sh"

### Prompt.

PS1='[\u@\h \W]\$ '

[[ -f $BASH/random-theme.sh ]] && . "$BASH/random-theme.sh"

PROMPT_RANDOM_CANDIDATES=(
    lambda
    minimal
    ys
)

### Path.

add_path "$HOME/vendors/build"

# Launch Emacs from terminal on macOS.  Put behind PATH to avoid
# overwritting universal-ctags.
add_path_behind "/Applications/Emacs.app/Contents/MacOS"
add_path_behind "/Applications/Emacs.app/Contents/MacOS/bin"

### Program.

# Rust.
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# Java.
add_path "/usr/local/opt/openjdk/bin"
export JAVA_TOOL_OPTIONS="-Duser.language=en -Duser.region=US -Dfile.encoding=UTF-8"

# Dotnet.
add_path "$HOME/.dotnet/tools"

# Andriod.
export PATH="$PATH:$HOME/Library/Android/sdk/cmdline-tools/latest/bin"
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"

# GO.
if [ -d "$HOME/go" ]; then
    export GOPATH="$HOME/go"
    add_path "$GOPATH/bin"
fi

# Flutter.
if [ -d "$HOME/flutter/bin" ]; then
    add_path "$HOME/flutter/bin"
    add_path "$HOME/.pub-cache/bin"
    export PUB_HOSTED_URL=https://pub.flutter-io.cn
    export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
fi

### Build.

# Erlang.
declare -a kerl_options

if check_cmd javac; then
    kerl_options+=("--disable-debug")
else
    kerl_options+=("--disable-debug" "--without-javac")
fi

check_cmd brew && kerl_options+=("--with-ssl=/usr/local/opt/openssl@1.1")

export KERL_BUILD_DOCS="yes"
export KERL_CONFIGURE_OPTIONS="${kerl_options[*]}"

# Ruby.
check_cmd brew && export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@3"

### Tools.

# Haskell.
[[ -f "$HOME/.ghcup/env" ]] && . "$HOME/.ghcup/env"

# Mise.
check_cmd mise && eval "$(mise activate zsh)"

# Zoxide.
check_cmd zoxide && eval "$(zoxide init bash)"

# Bun.
if [[ -d "$HOME/.bun" ]]; then
    export BUN_INSTALL="$HOME/.bun"
    add_path "$BUN_INSTALL/bin"
fi

# Pnpm.
if [[ -d "$HOME/Library/pnpm" ]]; then
    export PNPM_HOME="$HOME/Library/pnpm"
    add_path "$PNPM_HOME"
fi

# Homebrew.
export HOMEBREW_CLEANUP_MAX_AGE_DAYS=30
add_path "/usr/local/sbin"

# GTAGS.
if [[ -f $HOME/.globalrc ]]; then
    export GTAGSCONF=$HOME/.globalrc
elif [[ -f /usr/local/share/gtags/gtags.conf ]]; then
    export GTAGSCONF=/usr/local/share/gtags/gtags.conf
elif [[ -f /usr/share/global/gtags/gtags.conf ]]; then
    export GTAGSCONF=/usr/share/global/gtags/gtags.conf
elif [[ -f /etc/gtags/gtags.conf ]]; then
    export GTAGSCONF=/etc/gtags/gtags.conf
fi
export GTAGSLABEL=native-pygments

# Color `man`.
[[ -f "$BASH/plugins/colorman.sh" ]] && . "$BASH/plugins/colorman.sh"

# Lazyload `thefuck`.
if check_cmd thefuck; then
    _my_lazyload_command_fuck() {
        eval "$(thefuck --alias)"
    }

    my_lazyload_add_command fuck
fi

# Load `.bashrc.local` if it exists.
[[ -f "$HOME/.bashrc.local" ]] && . "$HOME/.bashrc.local"
