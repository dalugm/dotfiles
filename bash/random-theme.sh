#!/usr/bin/env bash

# Strict check if variable is array.
if [[ -n "${PROMPT_RANDOM_CANDIDATES[@]}" ]]; then
    themes=("${PROMPT_RANDOM_CANDIDATES[@]}")
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
file="$BASH/themes/$theme.bash-theme"

# Source theme if exists.
if [[ -f "$file" ]]; then
    source "$file" || exit
    echo "Theme '$theme' loaded"
    return 0
else
    echo "Theme '$theme' not found" >&2
    return 1
fi
