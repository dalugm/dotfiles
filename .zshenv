[[ -d "$HOME"/.bun/bin ]] && export PATH="$PATH:$HOME/.bun/bin"
[[ -s "$HOME"/.bun/_bun ]] && source "$HOME"/.bun/_bun

[[ -d "$HOME"/.local/bin ]] && export PATH="$PATH:$HOME/.local/bin"

[[ -f "$HOME"/.cargo/env ]] && . "$HOME"/.cargo/env

[[ -d "$HOME"/.local/share/coursier/bin ]] && export PATH="$PATH:$HOME/.local/share/coursier/bin"
