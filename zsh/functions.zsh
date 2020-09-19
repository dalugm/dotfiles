#############
# LAZY LOAD #
#############

#
## Setup a mock function for lazyload
## Usage:
## 1. Define function "_dalu_lazyload_command_[command name]" that will init the command
## 2. dalu_lazyload_add_command [command name]
#

# dalu_lazyload_add_command() {
#     eval "$1() { \
#             unfunction $1 \
#             _dalu_lazyload__command_$1 \
#             $1 \$@ \
#         }"
# }

#
## Setup autocompletion for lazyload
## Usage:
## 1. Define function "_dalu_lazyload_completion_[command name]" that will init the autocompletion
## 2. dalu_lazyload_add_comp [command name]
#

# dalu_lazyload_add_completion() {
#     local comp_name="_dalu_lazyload__compfunc_$1"
#     eval "${comp_name}() { \
#         compdef -d $1; \
#         _dalu_lazyload_completion_$1; \
#     }"
#     compdef $comp_name $1
# }
