#!/usr/env/bin zsh

# bash-like default enhanced theme
#   [user@hostname: ~] master # ...

PROMPT='[%F{green}%n%f@%F{blue}%m%f: %F{yellow}%1~%f]'
PROMPT+='${vcs_info_msg_0_} %(?.#.%F{red}#%f) '

RPROMPT='%F{grey}%*%f'

# Set the continuation interactive prompt.
# > ...
PS2="$fg[magenta]> $reset_color"
