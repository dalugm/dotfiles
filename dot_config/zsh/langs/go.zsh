if [[ -d "$HOME/go" ]]; then
    export GOPATH="$HOME/go"
    add_path "$GOPATH/bin"
fi
