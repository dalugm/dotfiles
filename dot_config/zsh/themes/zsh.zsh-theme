#!/usr/env/bin zsh

# zsh-like theme
#   user@hostname ~ master % ...

PROMPT='%F{green}%n%f@%F{blue}%m%f %F{yellow}%1~%f'
#PROMPT+='${vcs_info_msg_0_}'
PROMPT+=' %(?.%#.%F{red}%#%f) '

RPROMPT='%F{grey}%*%f'

# Set the continuation interactive prompt
# > ...
PS2="$fg[magenta]> $reset_color"
