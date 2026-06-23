# mise — runtime version manager
command_exists mise && eval "$(mise activate zsh)"
# zoxide — smarter cd
command_exists zoxide && eval "$(zoxide init zsh)"

# fzf — fuzzy finder
if command_exists fzf; then
    source <(fzf --zsh)
    export FZF_DEFAULT_OPTS="--preview 'fzf-preview.sh {}' \
--bind 'ctrl-a:preview-top' \
--bind 'ctrl-e:preview-bottom' \
--bind 'ctrl-f:preview-page-down' \
--bind 'ctrl-b:preview-page-up' \
--bind 'ctrl-d:preview-half-page-down' \
--bind 'ctrl-u:preview-half-page-up' \
--bind 'ctrl-j:preview-down' \
--bind 'ctrl-k:preview-up' \
--bind 'ctrl-g:toggle-preview'"
fi

if [[ -d "$HOME/.bun" ]]; then
    export BUN_INSTALL="$HOME/.bun"
    add_path "$BUN_INSTALL/bin"
    [[ -s "$BUN_INSTALL/_bun" ]] && . "$BUN_INSTALL/_bun"
fi

if [[ -d "$HOME/Library/pnpm" ]]; then
    export PNPM_HOME="$HOME/Library/pnpm"
    add_path "$PNPM_HOME"
elif [[ -d "$HOME/.local/share/pnpm" ]]; then
    export PNPM_HOME="$HOME/.local/share/pnpm"
    add_path "$PNPM_HOME"
fi

if command_exists brew; then
    export HOMEBREW_CLEANUP_MAX_AGE_DAYS=30
    add_path "/usr/local/sbin"
fi

if [[ -f "$HOME/.globalrc" ]]; then
    export GTAGSCONF="$HOME/.globalrc"
elif [[ -f /usr/local/share/gtags/gtags.conf ]]; then
    export GTAGSCONF=/usr/local/share/gtags/gtags.conf
elif [[ -f /opt/homebrew/share/gtags/gtags.conf ]]; then
    export GTAGSCONF=/opt/homebrew/share/gtags/gtags.conf
elif [[ -f /usr/share/global/gtags/gtags.conf ]]; then
    export GTAGSCONF=/usr/share/global/gtags/gtags.conf
fi
export GTAGSLABEL=native-pygments

export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"
export SCREENDIR="$HOME/.local/run/screen"
