[[ -d "$HOME"/.bun/bin ]] && export PATH="$PATH:$HOME/.bun/bin"
[[ -s "$HOME"/.bun/_bun ]] && source "$HOME"/.bun/_bun

[[ -d "$HOME"/.local/bin ]] && export PATH="$PATH:$HOME/.local/bin"
[[ -d "$HOME"/go/bin ]] && export PATH="$PATH:$HOME/go/bin"
[[ -d "$HOME"/.dotnet/tools ]] && export PATH="$PATH:$HOME/.dotnet/tools"
[[ -f "$HOME"/.cargo/env ]] && . "$HOME"/.cargo/env

[[ -d "$HOME"/flutter/bin ]] && export PATH="$PATH:$HOME/flutter/bin"
[[ -d "$HOME"/.pub-cache/bin ]] && export PATH="$PATH:$HOME/.pub-cache/bin"

# >>> coursier install directory >>>
[[ -d "$HOME"/.local/share/coursier/bin ]] && export PATH="$PATH:$HOME/.local/share/coursier/bin"
# <<< coursier install directory <<<
