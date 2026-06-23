declare -a kerl_options

if command_exists javac; then
    kerl_options+=("--disable-debug")
else
    kerl_options+=("--disable-debug" "--without-javac")
fi

command_exists brew && kerl_options+=("--with-ssl=/usr/local/opt/openssl@1.1")

export KERL_BUILD_DOCS="yes"
export KERL_CONFIGURE_OPTIONS="${kerl_options[*]}"
