#!/usr/env/bin bash

exit_code="%(?,,C:%{%F{red}%}%?%{$reset_color%})"

#
# Sets the prompt statement variables.
#
set_prompts() {

    # Overwrite the default PS1
    #   user@hostname ~ %
    PS1="%{%F{green}%}%n@%m %{%F{cyan}%}%~ %{$reset_color%}"

    # Set the default interactive prompt.
    #   user@hostname ~ [master +!?$]
    #   $ ...
    PS1+="%{%F{white}%}[%*] $exit_code%{%F{reset}%}"
    PS1+="$(git_prompt_info)"
    PS1+=$'\n'
    PS1+="%{%F{black}%}\$%{%F{reset}%} "

    # Set the continuation interactive prompt.
    # > ...
    PS2="%{%F{purple}}> %{$reset%}"

    export PS1
    export PS2
}

set_prompts
unset -f set_prompts
