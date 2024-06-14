#!/usr/env/bin zsh

# zsh simple theme
#   user@hostname: ~ master
#   $ ...

PROMPT='%F{green}%n%f@%F{blue}%m%f: %F{magenta}%~%f${vcs_info_msg_0_} [%F{grey}%*%f]'

PROMPT+=$'\n'
PROMPT+="%(?.$.%F{red}$%f)%b%f "

# Set the continuation interactive prompt.
# > ...
PS2="$fg[magenta]> $reset_color"