#!/usr/bin/env bash

set -eo pipefail

# Strict check if variable is array.
if [[ $(declare -p PROMPT_RANDOM_CANDIDATES 2>/dev/null) =~ 'declare -a' ]]; then
    themes=("${PROMPT_RANDOM_CANDIDATES[@]}")
elif [[ -n "$PROMPT_RANDOM_CANDIDATES" ]]; then
    echo "PROMPT_RANDOM_CANDIDATES not an array!" >&2
    exit 1
else
    themes=("$BASH/themes/"*.bash-theme)
fi

# Check if themes array not empty.
((${#themes[@]})) || {
    echo "No themes found" >&2
    exit 1
}

# Randomly pick a theme.
theme="${themes[RANDOM % ${#themes[@]}]}"

# Source theme if exists.
if [[ -f "$theme" ]]; then
    source "$theme" || exit
    # Show loaded theme name
    theme="${theme##*/}"
    theme="${theme%.*}"
    echo "Theme '$theme' loaded"
    return 0
else
    echo "Theme $theme not found" >&2
    return 1
fi
