################################
#       PROMPT EXPANSION       #
################################
# %B 加粗 %b 取消加粗          #
# %F{} 前景色 %f 取消前景色    #
# %F{n} enable ANSI color `n`  #
# %K{} 背景色 %k 取消背景色    #
# %U 下滑线 %u 取消下滑线      #
# %S 反色 %s 取消反色          #
# :                            #
# black or 0  red     or 1     #
# green or 2  yellow  or 3     #
# blue  or 4  magenta or 5     #
# cyan  or 6  white   or 7     #
# :                            #
# %{%F{cyan}%}                 #
# %{%F{reset}%}                #
# %f                           #
# :                            #
# %{$fg[green]%}               #
# %{$reset_color%}             #
# :                            #
# %{$terminfo[bold]%}          #
# %{$terminfo[bold]%F{cyan}%}  #
# %{%BF{cyan}%}                #
# %{$fg_bold[green]%}          #
# :                            #
# $(function)                  #
# :                            #
# %n          -- username      #
# %m          -- host          #
# %M          -- hostname      #
# %(?..[%?]:) -- error code    #
# %~          -- dir           #
# %1~         -- current dir   #
# $'\n'       -- new line      #
# %%          -- %             #
# %{n}<...<   -- compress to n #
################################

# Make themes a unique array
typeset -Ua themes

# enable diff color if possible.
if command diff --color . . &>/dev/null; then
    alias diff='diff --color'
fi

if [[ "${(t)PROMPT_RANDOM_CANDIDATES}" = array && ${#PROMPT_RANDOM_CANDIDATES[@]} -gt 0 ]]; then
    # Use PROMPT_RANDOM_CANDIDATES if properly defined
    themes=(${(@)PROMPT_RANDOM_CANDIDATES:#random})
else
    # Look for themes under $ZSH/themes
    themes=("$ZSH"/themes/*.zsh-theme(N:t:r))
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
