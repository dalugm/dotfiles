###############################
#      A Brief Intro          #
# %{%F{cyan}%}                #
# %{%F{reset}%}               #
# :                           #
# %{$fg[green]%}              #
# %{$reset_color%}            #
# :                           #
# %{$terminfo[bold]%}         #
# %{$terminfo[bold]%F{cyan}%} #
# :                           #
# $(function)                 #
# :                           #
# %n          -- username     #
# %m          -- host         #
# %M          -- hostname     #
# %(?..[%?]:) -- error code   #
# %~          -- dir          #
# %1~         -- current dir  #
# $'\n'       -- new line     #
# %%          -- %            #
###############################

# Make themes a unique array
typeset -Ua themes

# enable diff color if possible.
if command diff --color . . &>/dev/null; then
    alias diff='diff --color'
fi

# git theming default: Variables for theming the git info prompt
GIT_PROMPT_PREFIX="git:("         # Prefix at the very beginning of the prompt, before the branch name
GIT_PROMPT_SUFFIX=")"             # At the very end of the prompt
GIT_PROMPT_DIRTY="*"              # Text to display if the branch is dirty
GIT_PROMPT_CLEAN=""               # Text to display if the branch is clean

if [[ "${(t)PROMPT_RANDOM_CANDIDATES}" = array && ${#PROMPT_RANDOM_CANDIDATES[@]} -gt 0 ]]; then
    # Use PROMPT_RANDOM_CANDIDATES if properly defined
    themes=(${(@)PROMPT_RANDOM_CANDIDATES:#random})
else
    # Look for themes under $ZSH/themes
    themes=(
        "$ZSH"/themes/*.zsh-theme(N:t:r)
    )
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
    echo "[zsh] Theme '${RANDOM_THEME}' not found"
    return 1
fi

echo "[zsh] Theme '${RANDOM_THEME}' loaded"
