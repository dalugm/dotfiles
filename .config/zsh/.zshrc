#!/usr/bin/env zsh

# ${HOME}/.zshrc: executed by zsh(1) for non-login shells.
# If not running interactively, don't do anything.
[[ -z "$PS1" ]] && return

# For Performance Debug purpose.
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
# Distribute zshrc into smaller, more specific files.
export ZDOTDIR="$HOME"/.config/zsh

### Basic.

# Set the default language.
export LANG=en_US.UTF-8

# Set the default collation order as in C.
export LC_COLLATE='C'

# Set TERM value.
# export TERM=xterm-24bit
# export TERM=xterm-256color

# ls colors.
autoload -U colors && colors

export EDITOR='vim'
export ALTERNATE_EDITOR='nano'

### History.

# Consistent with .bash_history, .psql_histroy, etc.
HISTFILE="$HOME"/.zsh_history

# The maximum number of lines to remember in the command history.
HISTSIZE=1000

# The maximum number of history events to save in the history file.
SAVEHIST=$HISTSIZE

# Share history between multi zsh sessions.
setopt SHARE_HISTORY

# Add timestamp for history commands.
setopt EXTENDED_HISTORY

# Ignore duplicate commands.
setopt HIST_IGNORE_DUPS

# Ignore duplicate history path.
setopt PUSHD_IGNORE_DUPS

# Ignore command with a space ahead.
setopt HIST_IGNORE_SPACE

### Keybinding.

# [DEFAULT] Use $EDITOR key bindings

# Use EMACS key bindings
bindkey -e

# Use VIM key bindings
#bindkey -v

# eXecute Editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-o' edit-command-line     # VIM style
bindkey '\C-x\C-e' edit-command-line # EMACS style

# [Ctrl-r] - Search backward incrementally for a specified string.
# The string may begin with ^ to anchor the search to the beginning of the line.
bindkey '^r' history-incremental-search-backward

### Better defaults.

[[ -f "$ZDOTDIR"/function.zsh ]] && . "$ZDOTDIR/function.zsh"
[[ -f "$ZDOTDIR"/alias.zsh ]] && . "$ZDOTDIR/alias.zsh"
[[ -f "$ZDOTDIR"/completion.zsh ]] && . "$ZDOTDIR/completion.zsh"

# Color `man`.
[[ -f "$ZDOTDIR"/plugins/colorman.sh ]] && . "$ZDOTDIR"/plugins/colorman.sh

### Prompt.

autoload -Uz promptinit && promptinit

# https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
# https://stackoverflow.com/questions/1128496/to-get-a-prompt-which-indicates-git-branch-in-zsh
autoload -Uz vcs_info

# Executed before every command run in the terminal.
precmd() { vcs_info }

setopt PROMPT_SUBST

# # Keep track of what's going on in vcs_info
# zstyle ':vcs_info:*+*:*' debug true

# %s => vc system
# %b => current branch
# %i => hash

zstyle ':vcs_info:git:*' formats '%F{cyan} %b%f'

# zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

# # http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#vcs_005finfo-Hooks
# # Append '?' to `unstaged (%u)` if there are any untracked files.
# +vi-git-untracked() {
#     if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
#            git status --porcelain | grep -m 1 '^??' &>/dev/null; then
#         # Append to unstaged (%u).
#         hook_com[unstaged]='?'
#     fi
# }

PROMPT_RANDOM_CANDIDATES=(
    bash
    simple
    zsh
)

[[ -f "$ZDOTDIR"/random-theme.zsh ]] && . "$ZDOTDIR"/random-theme.zsh

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
[[ -f "${HOME}"/.opam/opam-init/init.zsh ]] && . "${HOME}"/.opam/opam-init/init.zsh
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

#### Java.
add_path "/usr/local/opt/openjdk/bin"
add_path "/opt/homebrew/opt/openjdk/bin"
export JAVA_TOOL_OPTIONS="-Duser.language=en -Duser.region=US -Dfile.encoding=UTF-8"

#### Scala.
export SBT_OPTS="-Dsbt.override.build.repos=true"

#### Dotnet.
add_path "$HOME"/.dotnet/tools

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

#### Mise.
check_cmd mise && eval "$(mise activate zsh)"

#### Zoxide.
check_cmd zoxide && eval "$(zoxide init zsh)"

#### Bun.
if [[ -d "$HOME"/.bun ]]; then
    export BUN_INSTALL="$HOME"/.bun
    add_path "$BUN_INSTALL"/bin
    # Completions.
    [[ -s "$BUN_INSTALL"/_bun ]] && . "$BUN_INSTALL"/_bun
fi

#### Pnpm.
if [[ -d "$HOME"/Library/pnpm ]]; then
    export PNPM_HOME="$HOME"/Library/pnpm
    add_path "$PNPM_HOME"
fi

if [[ -d "$HOME"/.local/share/pnpm ]]; then
    export PNPM_HOME="$HOME"/.local/share/pnpm
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
        eval $(thefuck --alias)
    }

    my_lazyload_add_command fuck
fi

### Load `.zshrc.local` if exists.
[[ -f "$ZDOTDIR"/.zshrc.local ]] && . "$ZDOTDIR"/.zshrc.local

### DEBUG.

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
                    time_difference=$(($this_time - $prev_time))
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
        done <${1:-/dev/stdin}

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

## Local Variables:
## outline-regexp: "###"
## End:
