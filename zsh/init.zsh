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
export ZSH=$HOME/.config/zsh

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

# Preferred editor for local and remote sessions.
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
    export ALTERNATE_EDITOR='nano'
else
    export EDITOR='nano'
    export ALTERNATE_EDITOR='vim'
fi

### History.

# Lines configured by zsh-newuser-install.
export HISTFILE=~/.zsh_history

# The maximum number of lines to remember in the command history.
export HISTSIZE=1000

# The maximum number of lines to save in the history file.
export HISTFILESIZE=1000

# The maximum number of history events to save in the history file.
export SAVEHIST=1000

# Disable saving lines that begin with a space or match the last history
# line to the history list.
export HISTCONTROL='ignoreboth'

# Disable saving the following commands to the history list.
export HISTIGNORE='&:bg:fg'

# Enable time stamp for `history` builtin.
export HISTTIMEFORMAT='%F %T '

# Share history between multi zsh sessions.
setopt SHARE_HISTORY

# Ignore duplicate commands.
setopt HIST_IGNORE_DUPS

# Add timestamp for history commands.
#setopt EXTENDED_HISTORY

# cd - to enter history path.
setopt AUTO_PUSHD

# Ignore duplicate history path.
setopt PUSHD_IGNORE_DUPS

# Ignore command with a space ahead.
setopt HIST_IGNORE_SPACE

### Keybinding.

# [DEFAULT] Use $EDITOR key bindings

# Use EMACS key bindings
bindkey -e

# # Use VIM key bindings
# bindkey -v

# eXecute Editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-o' edit-command-line     # VIM style
bindkey '\C-x\C-e' edit-command-line # EMACS style

# [Ctrl-r] - Search backward incrementally for a specified string.
# The string may begin with ^ to anchor the search to the beginning of the line.
bindkey '^r' history-incremental-search-backward

### Better defaults.

[[ -f "$ZSH/function.zsh" ]] && . "$ZSH/function.zsh"
[[ -f "$ZSH/alias.zsh" ]] && . "$ZSH/alias.zsh"
[[ -f "$ZSH/completion.zsh" ]] && . "$ZSH/completion.zsh"

### Completion.

# Enable additional programmable completion features.
[[ -d /usr/local/share/zsh-completions ]] && fpath=(/usr/local/share/zsh-completions $fpath)

### Prompt.

setopt PROMPT_SUBST

autoload -Uz promptinit
promptinit

# # You can also use builtin vcs_info instead of themes
# # https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
# # https://stackoverflow.com/questions/1128496/to-get-a-prompt-which-indicates-git-branch-in-zsh
# autoload -Uz vcs_info

[[ -f "$ZSH/random-theme.zsh" ]] && . "$ZSH/random-theme.zsh"

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
add_path_behind "$HOME/Library/Android/sdk/cmdline-tools/latest/bin"
add_path_behind "$HOME/Library/Android/sdk/platform-tools"

# GO.
if [[ -d "$HOME/go" ]]; then
    export GOPATH="$HOME/go"
    add_path "$GOPATH/bin"
fi

# Flutter.
if [[ -d "$HOME/flutter/bin" ]]; then
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
check_cmd zoxide && eval "$(zoxide init zsh)"

# Bun.
if [[ -d "$HOME/.bun" ]]; then
    export BUN_INSTALL="$HOME/.bun"
    add_path "$BUN_INSTALL/bin"
    # Completions.
    [[ -s "$BUN_INSTALL/_bun" ]] && . "$BUN_INSTALL/_bun"
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
[[ -f $ZSH/plugins/colorman.sh ]] && source $ZSH/plugins/colorman.sh

# Lazyload `thefuck`.
if check_cmd thefuck; then
    _my_lazyload_command_fuck() {
        eval $(thefuck --alias)
    }

    my_lazyload_add_command fuck
fi

# zsh-completions.
[[ -d "$ZSH/plugins/zsh-completions" ]] && . "$ZSH/plugins/zsh-completions/zsh-completions.plugin.zsh"

# zsh-autosuggestions.
[[ -d "$ZSH/plugins/zsh-autosuggestions" ]] && . "$ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

# zsh-syntax-highlighting.
[[ -d "$ZSH/plugins/zsh-syntax-highlighting" ]] && . "$ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Load `.zshrc.local` if it exists.
[[ -f "${HOME}/.zshrc.local" ]] && . "${HOME}/.zshrc.local"

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

# bun completions
[ -s "/Users/mou/.bun/_bun" ] && source "/Users/mou/.bun/_bun"
