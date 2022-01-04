#!/usr/bin/env -S bash

# set -x
# set -e
# set -o posix

# set -euo pipefail
# set -o errexit 

# IFS=$'\n\t'


# #########################
# # Shell scripting helpers
# #########################



# for i in $HOME/.local/include/*;
#   do source $i
# done



BASE_DIR="$PWD"
UTILS_DIR="$BASE_DIR/scripts/utils.sh"



source "$UTILS_DIR"


# get_functions

does_dir_exist "$BASE_DIR/scripts"
echo "$?"

does_dir_exist "$BASE_DIR/script"
echo "$?"


generate_uuid
echo "$?"


is_undefined
echo "$?"

is_undefined "string value"
echo "$?"