#!/usr/bin/env zsh

local -a themes

# Simplified check
if [[ -n "$PROMPT_RANDOM_CANDIDATES[@]" ]]; then
    themes+=(${=PROMPT_RANDOM_CANDIDATES})
else
    themes+=("$ZDOTDIR"/themes/*.zsh-theme(N:t:r))
fi

# Ensure we have themes to select
(( $#themes > 0 )) || return 1

integer rand=$RANDOM%$#themes+1
local theme=${themes[$rand]}

# Extracted theme file paths
local file="$ZDOTDIR"/themes/"$theme".zsh-theme

# Source theme if exists
if [[ -f "$file" ]]; then
    source "$file"
    echo "Theme '$theme' loaded"
    return 0
else
    echo "Theme '$theme' not found" >&2
    return 1
fi
