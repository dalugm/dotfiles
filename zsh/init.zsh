# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} r:|[._-]=** r:|=**' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=0
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/Users/mou/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install

# Useful configurations
source ~/.config/zsh/lib/git.zsh
source ~/.config/zsh/lib/completion.zsh
source ~/.config/zsh/lib/key-bindings.zsh
source ~/.config/zsh/lib/theme-and-appearance.zsh

# Plugins
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# Theme
source ~/.config/zsh/themes/ys.zsh-theme

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

############################################################
#                  => personal config <=                   #
############################################################

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
# Example aliases
alias zshconfig="nvim ~/.zshrc"
alias tmuxconfig="nvim ~/.tmux.conf"
alias alaconfig="nvim ~/.alacritty.yml"
alias ytdlconfig="nvim ~/.config/youtube-dl/config"
alias chainizi="python ~/src/misc/zhenghuo/chainizi.py"

alias g='git'
alias vi='vim'
alias nvi='nvim'
alias gvim='/Applications/MacVim.app/Contents/MacOS/MacVim'
alias pc='proxychains4'
alias sicp='mit-scheme'
alias markdown='/Applications/Typora.app/Contents/MacOS/Typora'
alias firefox='/Applications/Firefox.app/Contents/MacOS/firefox'
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

alias screen="/usr/local/bin/screen"
alias dscreen="/usr/bin/screen"

# proxy
alias socks5_proxy="export all_proxy=socks5://127.0.0.1:1080; export http_proxy=socks5://127.0.0.1:1080; export https_proxy=socks5://127.0.0.1:1080"
alias http_proxy="export all_proxy=http://127.0.0.1:1087; export http_proxy=http://127.0.0.1:1087; export https_proxy=http://127.0.0.1:1087"
alias clean_proxy="export all_proxy=; export http_proxy=; export https_proxy="

# @see http://stackoverflow.com/questions/3746/whats-in-your-bashrc
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# eXecute Editor
autoload -U   edit-command-line
zle      -N   edit-command-line
bindkey  '^o' edit-command-line

############################################################
#                      => export <=                        #
############################################################
# Personal PATH
export PATH="$HOME/tools/build:$PATH"

# GO
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$PATH"

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# Ruby
export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

if command -v rbenv 1>/dev/null 2>&1; then
    eval "$(rbenv init -)"
fi

# HOMEBREW
# 关闭 homebrew 自动更新
export HOMEBREW_NO_AUTO_UPDATE=true
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
