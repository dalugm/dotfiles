#!/usr/env/bin zsh

# zsh simple theme
#   user@hostname: ~ master [01:02:03]
#   $ ...

PROMPT='%F{green}%n%f@%F{blue}%m%f: %F{magenta}%~%f'
#PROMPT+=' ${vcs_info_msg_0_}'
PROMPT+=' [%F{grey}%*%f]'

PROMPT+=$'\n'
PROMPT+="%(?.$.%F{red}$%f)%b%f "

# Set the continuation interactive prompt
# > ...
PS2="$fg[magenta]> $reset_color"