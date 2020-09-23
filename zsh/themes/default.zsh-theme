# zsh default enhanced theme

# features:
# path is auto shortened to ~30 characters
# displays git status (if applicable in current folder)

#
# Sets the prompt statement variables.
#

# Overwrite the default PS1
#   user@hostname ~ %
PS1="%{%F{green}%}%n%f@%{%F{blue}%}%m %f"
PS1+="%{%F{yellow}%}%30<...<%~ %<<%f"
PS1+="%# "

RPROMPT='%{%F{magenta}%}$(git_prompt_info)%f'

# Set the continuation interactive prompt.
# > ...
PS2="%{$fg[purple]%}> %{$reset_color%}"
