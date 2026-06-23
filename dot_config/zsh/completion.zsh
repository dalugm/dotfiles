# Enable path expansion, e.g. /v/c/p/p => /var/cache/pacman/pkg
setopt complete_in_word

# Treat the following chars as word boundaries
WORDCHARS='*?[]~=/&;!#$%^(){}<>'

setopt AUTO_LIST

# Do NOT auto select the first completion entry
unsetopt MENU_COMPLETE

# Show completion menu on successive tab press
setopt AUTO_MENU

# Case-insensitive completion from the start,
# then allow substring matching on subsequent attempts
zstyle ':completion:*' matcher-list \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# Show completion menu if 2 or more items, enable arrow key navigation
zstyle ':completion:*' menu select=2
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'

# Auto-add new executables to completion hash
zstyle ':completion:*' rehash true

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

# Colorful completion list
export ZLSCOLORS=$LS_COLORS
zmodload zsh/complist

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# Enable zsh completion system
autoload -Uz compinit && compinit

# Load bash completion functions for compatibility
autoload -U +X bashcompinit && bashcompinit
