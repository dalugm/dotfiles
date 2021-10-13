# Make themes a unique array
typeset -a themes

if [[ "${PROMPT_RANDOM_CANDIDATES}" = array && ${#PROMPT_RANDOM_CANDIDATES[@]} -gt 0 ]]; then
    # Use PROMPT_RANDOM_CANDIDATES if properly defined
    themes=(${(@)PROMPT_RANDOM_CANDIDATES:#random})
else
    # Look for all themes under $BASH/themes
    themes=("$BASH"/themes/*.bash-theme)
fi

# Choose a theme out of the pool of candidates
N=$RANDOM%${#themes[@]}
RANDOM_THEME="${themes[$N]}"

# Source theme
if [[ -f "$RANDOM_THEME" ]]; then
    source "$RANDOM_THEME"
else
    echo "[bash] '${RANDOM_THEME}' not found"
    return 1
fi

RANDOM_THEME=${RANDOM_THEME##*/}
RANDOM_THEME=${RANDOM_THEME%.*}

echo "[bash] Theme '${RANDOM_THEME}' loaded"
