# The following lines were added by compinstall

# 扩展路径
# /v/c/p/p => /var/cache/pacman/pkg
setopt complete_in_word

# 以下字符视为单词的一部分
WORDCHARS='*?[]~=/&;!#$%^(){}<>'

setopt AUTO_LIST

# do NOT auto select the first completion entry
unsetopt MENU_COMPLETE

# show completion menu on successive tab press
setopt AUTO_MENU

# enable zsh completion
autoload -Uz compinit && compinit

# 修正大小写
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# Show completion menu if 2 or more items to select and enable arrow key
zstyle ':completion:*' menu select=2
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'

# 新文件自动添加到自动补全当中
zstyle ':completion:*' rehash true

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

# colorful complete list
export ZLSCOLORS=$LS_COLORS
zmodload zsh/complist

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit

# End of lines added by compinstall
