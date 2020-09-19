# Make themes a unique array
typeset -Ua themes

if [[ "${(t)ZSH_THEME_RANDOM_CANDIDATES}" = array && ${#ZSH_THEME_RANDOM_CANDIDATES[@]} -gt 0 ]]; then
    # Use ZSH_THEME_RANDOM_CANDIDATES if properly defined
    themes=(${(@)ZSH_THEME_RANDOM_CANDIDATES:#random})
else
    # Look for themes under $ZSH/themes
    themes=(
        "$ZSH"/themes/*.zsh-theme(N:t:r)
    )
    # Remove blacklisted themes from the list
    for theme in random ${ZSH_THEME_RANDOM_BLACKLIST[@]}; do
        themes=("${(@)themes:#$theme}")
    done
fi

# Choose a theme out of the pool of candidates
N=${#themes[@]}
(( N = (RANDOM%N) + 1 ))
RANDOM_THEME="${themes[$N]}"
unset N themes theme

# Source theme
if [[ -f "$ZSH/$RANDOM_THEME.zsh-theme" ]]; then
    source "$ZSH/$RANDOM_THEME.zsh-theme"
elif [[ -f "$ZSH/themes/$RANDOM_THEME.zsh-theme" ]]; then
    source "$ZSH/themes/$RANDOM_THEME.zsh-theme"
elif [[ -f "$ZSH/themes/$RANDOM_THEME.zsh-theme" ]]; then
    source "$ZSH/themes/$RANDOM_THEME.zsh-theme"
else
    echo "[zsh] Random theme '${RANDOM_THEME}' not found"
    return 1
fi

echo "[zsh] Random theme '${RANDOM_THEME}' loaded"
