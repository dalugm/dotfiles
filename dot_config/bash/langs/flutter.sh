if [[ -d "$HOME/flutter/bin" ]]; then
    add_path "$HOME/flutter/bin"
    add_path "$HOME/.pub-cache/bin"
    export PUB_HOSTED_URL=https://pub.flutter-io.cn
    export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
fi
