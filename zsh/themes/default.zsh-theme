# zsh default enhanced theme

# features:
# path is auto shortened to ~30 characters
# displays git status (if applicable in current folder)

#
# Sets the prompt statement variables.
#
set_prompts() {

    # Overwrite the default PS1
    #   user@hostname ~ %
    PS1="%{$fg[green]%}%n@%m %{$fg[blue]%}%30<...<%~%<< %{$fg[grey]%}%# "

    RPROMPT=$'%{%F{magenta}%}$(git_prompt_info)%{%F{reset_color}%}'

    # Set the continuation interactive prompt.
    # > ...
    PS2="%{$fg[purple]%}> %{$reset_color%}"

    RPROMPT=''

    export PS1
    export PS2
}

set_prompts
unset -f set_prompts
