#!/usr/env/bin bash

#
# Sets the prompt statement variables.
#
set_prompts() {

    # Overwrite the default PS1
    #   user@hostname ~ %
    PS1="%{$fg[green]%}%n@%m %{$fg[blue]%}%1~ %{$fg[grey]%}%# "

    # Set the continuation interactive prompt.
    # > ...
    PS2="%{$fg[purple]}> %{$reset_color%}"

    export PS1
    export PS2
}

set_prompts
unset -f set_prompts
