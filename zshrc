# If you come from bash you might have to change your $PATH.
# export PATH=/usr/local/bin:$HOME/bin:$PATH

# Path to your oh-my-zsh installation.
 export ZSH=/Users/mou/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
 ZSH_THEME="spaceship"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=(
#                                "ys"
#                                "spaceship"
#)

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
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  z
  osx
  git
  emacs
  extract
  autojump
  web-search
  zsh-completions
  last-working-dir
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

 export MANPATH="/usr/local/share/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='emacs'
 fi

 [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Modify zsh's themes configuration
###########################################################
#                  => spaceship <=                        #
###########################################################

# Directory (dir)

# Number of folders of cwd to show in prompt, 0 to show all
SPACESHIP_DIR_TRUNC=0

###########################################################
#               => Personal Config <=                     #
###########################################################
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
 alias vimconfig="vim ~/.vimrc"
 alias zshconfig="vim ~/.zshrc"
 alias tmuxconfig="vim ~/.tmux.conf.local"
 alias ohmyzsh="vim ~/.oh-my-zsh"
 alias emacsconfig="vim ~/.spacemacs"

 alias -s c=vim    # 在命令行直接输入 c 文件，会用 vim 中打开，以下类似
 alias -s h=vim
 alias -s cs=vim
 alias -s sh=vim
 alias -s py=vim
 alias -s el=vim
 alias -s js=vim
 alias -s cpp=vim
 alias -s vim=vim
 alias -s java=vim

 alias ll='ls -l'
 alias la='ls -a'
 alias lg='lazygit'
 alias vi='vim'
 alias sicp="mit-scheme"
 alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
 alias gemacs='/Applications/Emacs.app/Contents/MacOS/Emacs'

 test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
 eval $(thefuck --alias)
 export PATH="/usr/local/opt/curl/bin:$PATH"

 # Config for zsh-completions
 autoload -U compinit && compinit
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
