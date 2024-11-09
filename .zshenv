[[ -d "$HOME"/.bun/bin ]] && export PATH="$PATH:$HOME/.bun/bin"
[[ -s "$HOME"/.bun/_bun ]] && source "$HOME"/.bun/_bun

[[ -d "$HOME"/.local/bin ]] && export PATH="$PATH:$HOME/.local/bin"
[[ -d "$HOME"/go/bin ]] && export PATH="$PATH:$HOME/go/bin"

[[ -f "$HOME"/.cargo/env ]] && . "$HOME"/.cargo/env

# >>> coursier install directory >>>
[[ -d "$HOME"/.local/share/coursier/bin ]] && export PATH="$PATH:$HOME/.local/share/coursier/bin"
# <<< coursier install directory <<<
