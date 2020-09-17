#!/usr/env/bin bash

#
# Lists all defined functions.
#
list_functions() {
  declare -F | grep -v '\-f _'
}

#
# Creates new directories and then enters the last one.
#
mkd() {
  mkdir -p "$@" && cd "$_" || exit 1
}

#
# Searches for text within bash history.
#
qh() {
  command -p grep --color=always -i -- "$*" "${HISTFILE}" | less -RX
}

#
# Searches for text within the current directory.
#
qt() {
  command -p grep --color=always -ir --exclude-dir={.git,node_modules} -- "$*" "${PWD}" | less -RX
}

#
# Converts text files with DOS line endings to Unix line endings.
#
crlf2lf() {
  cat "$@" <&0 | sed -e 's/\r$//g'
}

#
# Converts text files with Unix line endings to DOS line endings.
#
lf2crlf() {
  cat "$@" <&0 | sed -e 's/$/\r/g'
}

#
# Execute `git pull` on every directory within the current directory.
#
git-updateall() {
  find . \
    -maxdepth 1 \
    ! -path . \
    -type d \
    -print \
    -execdir git --git-dir={}/.git --work-tree="${PWD}/{}" pull --rebase \;
}