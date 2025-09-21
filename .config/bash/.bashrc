#!/usr/bin/env bash

# ${HOME}/.bashrc: executed by bash(1) for non-login shells.
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Path to bash installation.
# Distribute bashrc into smaller, more specific files.
export BASH="$HOME"/.config/bash

### Basic.

# Set the default language
export LANG=en_US.UTF-8

# Set the default collation order as in C.
export LC_COLLATE='C'

# Set TERM value
# export TERM=xterm-24bit
# export TERM=xterm-256color

export EDITOR='vim'
export ALTERNATE_EDITOR='nano'

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

[[ -f "$BASH"/function.sh ]] && . "$BASH"/function.sh
[[ -f "$BASH"/alias.sh ]] && . "$BASH"/alias.sh

# Color `man`.
[[ -f "$BASH"/plugins/colorman.sh ]] && . "$BASH"/plugins/colorman.sh

### Prompt.

# PS1='[\u@\h \W]\$ '

PROMPT_RANDOM_CANDIDATES=(
    bash
    simple
    zsh
)

[[ -f "$BASH"/random-theme.sh ]] && . "$BASH"/random-theme.sh

### Path.

add_path "$HOME"/.local/bin

### Langs.

#### Haskell.
export GHCUP_USE_XDG_DIRS=1
#[[ -f "$HOME"/.ghcup/env ]] && . "$HOME"/.ghcup/env

#### Ocaml.
# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ -f "${HOME}"/.opam/opam-init/init.sh ]] && . "${HOME}"/.opam/opam-init/init.sh
# END opam configuration

#### LLVM.
add_path "/usr/local/opt/llvm/bin"
add_path "/opt/homebrew/opt/llvm/bin"

#### Rust.
[[ -f "$HOME"/.cargo/env ]] && . "$HOME"/.cargo/env
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

#### GO.
if [[ -d "$HOME"/go ]]; then
    export GOPATH="$HOME"/go
    add_path "$GOPATH"/bin
fi

#### Dotnet.
add_path "$HOME"/.dotnet/tools

#### Java.
add_path "/usr/local/opt/openjdk/bin"
add_path "/opt/homebrew/opt/openjdk/bin"

#### Andriod.
add_path_behind "$HOME"/Android/sdk/cmdline-tools/latest/bin
add_path_behind "$HOME"/Android/sdk/platform-tools

add_path_behind "$HOME"/Library/Android/sdk/cmdline-tools/latest/bin
add_path_behind "$HOME"/Library/Android/sdk/platform-tools

#### Flutter.
if [[ -d "$HOME"/flutter/bin ]]; then
    add_path "$HOME"/flutter/bin
    add_path "$HOME"/.pub-cache/bin
    export PUB_HOSTED_URL=https://pub.flutter-io.cn
    export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
fi

#### Erlang.
declare -a kerl_options

if check_cmd javac; then
    kerl_options+=("--disable-debug")
else
    kerl_options+=("--disable-debug" "--without-javac")
fi

check_cmd brew && kerl_options+=("--with-ssl=/usr/local/opt/openssl@1.1")

export KERL_BUILD_DOCS="yes"
export KERL_CONFIGURE_OPTIONS="${kerl_options[*]}"

#### Ruby.
check_cmd brew && export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@3"

#### Mise.
check_cmd mise && eval "$(mise activate bash)"

#### Zoxide.
check_cmd zoxide && eval "$(zoxide init bash)"

#### Fzf.
if check_cmd fzf; then
    eval "$(fzf --bash)"

    FZF_DEFAULT_OPTS="--preview 'fzf-preview.sh {}' "
    FZF_DEFAULT_OPTS+="--bind 'ctrl-a:preview-top' "
    FZF_DEFAULT_OPTS+="--bind 'ctrl-e:preview-bottom' "
    FZF_DEFAULT_OPTS+="--bind 'ctrl-f:preview-page-down' "
    FZF_DEFAULT_OPTS+="--bind 'ctrl-b:preview-page-up' "
    FZF_DEFAULT_OPTS+="--bind 'ctrl-d:preview-half-page-down' "
    FZF_DEFAULT_OPTS+="--bind 'ctrl-u:preview-half-page-up' "
    FZF_DEFAULT_OPTS+="--bind 'ctrl-j:preview-down' "
    FZF_DEFAULT_OPTS+="--bind 'ctrl-k:preview-up' "
    FZF_DEFAULT_OPTS+="--bind 'ctrl-g:toggle-preview'"

    export FZF_DEFAULT_OPTS
fi

#### Bun.
if [[ -d "$HOME"/.bun ]]; then
    export BUN_INSTALL="$HOME"/.bun
    add_path "$BUN_INSTALL"/bin
fi

#### Pnpm.
if [[ -d "$HOME/Library/pnpm" ]]; then
    export PNPM_HOME="$HOME"/Library/pnpm
    add_path "$PNPM_HOME"
fi

#### Homebrew.
if check_cmd brew; then
    export HOMEBREW_CLEANUP_MAX_AGE_DAYS=30
    add_path "/usr/local/sbin"
fi

#### GTAGS.
if [[ -f "$HOME"/.globalrc ]]; then
    export GTAGSCONF="$HOME"/.globalrc
elif [[ -f /usr/local/share/gtags/gtags.conf ]]; then
    export GTAGSCONF=/usr/local/share/gtags/gtags.conf
elif [[ -f /usr/share/global/gtags/gtags.conf ]]; then
    export GTAGSCONF=/usr/share/global/gtags/gtags.conf
elif [[ -f /etc/gtags/gtags.conf ]]; then
    export GTAGSCONF=/etc/gtags/gtags.conf
fi
export GTAGSLABEL=native-pygments

#### Screen.
export SCREENRC="$XDG_CONFIG_HOME"/screen/screenrc
export SCREENDIR="$XDG_RUNTIME_DIR"/screen

#### Lazyload `thefuck`.
if check_cmd thefuck; then
    _my_lazyload_command_fuck() {
        eval "$(thefuck --alias)"
    }

    my_lazyload_add_command fuck
fi

### Load `.bashrc.local` if exists.
[[ -f "$BASH"/.bashrc.local ]] && . "$BASH"/.bashrc.local

## Local Variables:
## outline-regexp: "###"
## End:
