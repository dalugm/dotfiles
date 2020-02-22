# If you come from bash you might have to change your $PATH.
# export PATH=/usr/local/bin:$HOME/bin:$PATH

# Path to your oh-my-zsh installation.
 export ZSH=/Users/mou/.config/zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
 ZSH_THEME="random"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# For custom theme use `ln' to add it to candidate
# ln -s "$ZSH_CUSTOM/themes/[custom-theme]/[theme].zsh-theme" "$ZSH/themes/[theme].zsh-theme"
ZSH_THEME_RANDOM_CANDIDATES=(
                               "agnoster"
                               "robbyrussell"
                               "spaceship"
                               "ys"
)

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
 HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
 export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
 HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in `~/.config/zsh/plugins/*')
# Custom plugins may be added to ~/.config/zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    autojump
    colored-man-pages
    colorize
    command-not-found
    copydir
    copyfile
    cp
    emacs
    extract
    fzf
    git
    history
    last-working-dir
    osx
    screen
    tmux
    web-search
    z
    zsh_reload
    zsh-autosuggestions
    zsh-completions
    zsh-interactive-cd
    zsh-syntax-highlighting
)

 source $ZSH/oh-my-zsh.sh


# User configuration
 export MANPATH="/usr/local/share/man:$MANPATH"

# You may need to manually set your language environment
 export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='vim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
 export SSH_KEY_PATH="~/.ssh/rsa_id"

# Config for zsh-completions
 autoload -U compinit && compinit
 test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
 eval $(thefuck --alias)

# Config for zsh-autosuggestions

# Config for autojump
 [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Config for fzf
# Set fzf installation directory path
export FZF_BASE=/usr/local/opt/fzf/install

# Uncomment the following line to disable fuzzy completion
# export DISABLE_FZF_AUTO_COMPLETION="true"

# Uncomment the following line to disable key bindings (CTRL-T, CTRL-R, ALT-C)
# export DISABLE_FZF_KEY_BINDINGS="true"

# Config for term color
export TERM=xterm-256color
###########################################################
#                     => export <=                        #
###########################################################
 export PATH="/usr/local/opt/curl/bin:$PATH"
 export PATH="/usr/local/sbin:$PATH"
 export PATH="/Users/mou/.emacs.d/bin:$PATH"
 export PATH="/Users/mou/Library/Python/3.7/bin:$PATH"
 export PATH="/usr/local/opt/curl/bin:$PATH"
 export PATH="/usr/local/opt/sqlite/bin:$PATH"
 export PATH="/usr/local/opt/qt/bin:$PATH"

export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
###########################################################

# Modify zsh's themes configuration
###########################################################
#                  => spaceship <=                        #
###########################################################

# Directory (dir)

# Number of folders of cwd to show in prompt, 0 to show all
 SPACESHIP_DIR_TRUNC=0
###########################################################

###########################################################
#                  => personal config <=                  #
###########################################################
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
# Example aliases
 alias vimconfig="vim ~/.vimrc"
 alias zshconfig="vim ~/.zshrc"
 alias tmuxconfig="vim ~/.tmux.conf.local"
 alias ohmyzsh="vim ~/.oh-my-zsh"

 alias -s c=vim    # 在命令行直接输入 ./*.c 文件，会用 vim 中打开，以下类似
 alias -s h=vim
 alias -s cs=vim
 alias -s py=vim
 alias -s el=vim
 alias -s js=vim
 alias -s cpp=vim
 alias -s vim=vim
 alias -s java=vim

 alias ll='ls -l'
 alias la='ls -a'
 alias vi='vim'
 alias pc='proxychains4'
 alias sicp="mit-scheme"
 alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
 alias gemacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
 alias firefox='/Applications/Firefox.app/Contents/MacOS/firefox'
 alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

 alias python="/usr/local/bin/python3"
 alias screen="/usr/local/bin/screen"
 alias dscreen="/usr/bin/screen"
 alias python2="/usr/bin/python"
###########################################################

# 用 vim 编辑命令行 `C-o'
autoload -U       edit-command-line
zle -N            edit-command-line
bindkey '^o'      edit-command-line

###########################################################
#                   => npm-completion <=                  #
###########################################################
###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
###########################################################
