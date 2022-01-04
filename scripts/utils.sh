#!/usr/bin/env bash

# set -x
# set -e
# set -o posix

#set -euo pipefail
#set -o errexit 

# IFS=$'\n\t'

# day "$( echo "$(($(date +'%s * 1000 + %-N / 1000000')))"  )"

generate_uuid() {
  local input="$( od -x /dev/urandom | head -1 | awk '{OFS="-"; print $2$3,$4,$5,$6,$7$8$9}' )"
  local return_code="1"

  if [ -n "${input}" ]; then
    echo "${input}"
    return_code=0
    return "${return_code}"
  fi

  printf '%s\n' "[generate_uuid] ${input}"
  printf '%s\n' "Error: Failed to resolve generating UUID."
  # return "${return_code}"
  exit "${return_code}"
}


PATH_TO_SCRIPTS_DIR="$PWD"
declare -a INTERNAL_SCRIPTS_DIR_NAMES_ARRAY=(
  [0]="helpers"
  [1]="validators"
)
INTERNAL_SCRIPTS_DIR_NAMES_ARRAY_LENGTH="${#INTERNAL_SCRIPTS_DIR_NAMES_ARRAY[@]}"

declare -a INTERNAL_SCRIPTS_FILE_NAMES_ARRAY=()


for (( j=0; j<"$INTERNAL_SCRIPTS_DIR_NAMES_ARRAY_LENGTH"; j++ ));
  do
    for _i in "$PWD/${INTERNAL_SCRIPTS_DIR_NAMES_ARRAY[$j]}"
        do
        INTERNAL_SCRIPTS_FILE_NAMES_ARRAY=( "$_i" )
    done

done



# echo "${INTERNAL_SCRIPTS_FILE_NAMES_ARRAY[*]}"

# for dir_names in "$INTERNAL_SCRIPTS_DIR_NAMES_ARRAY";
#     echo "${dir_names}"
# #   for file_names in "${PATH_TO_SCRIPTS_DIR}/${INTERNAL_SCRIPTS_DIR_NAMES_ARRAY[$dir_names]}/*";
# #     echo "$file_names"
# #     # do source $file_names
# #   done
# done


trace_full_call_stack() {
  local CALL_STACK_CORREALATION_ID="${CALL_STACK_CORREALATION_ID:-$( generate_uuid )}"
  local CALL_STACK_TIMESTAMPdate="${CALL_STACK_CORREALATION_ID:-$( generate_uuid )}"

  printf '%s\n' "$CALL_STACK_CORREALATION_ID"

  local func_name
  local func_idx
  local func_argv
  local func_code
  local func_loc

  declare -a FUNC_PROPS=(
    [0]="$func_name"
    [1]="$func_idx"
    [2]="$func_argv"
    [3]="$func_code"
    [4]="$func_loc"
  )

  local tmp=${1:-.}

#   printf '%s\n' "${FUNCNAME[@]}"
#   printf '%s\n' "${#FUNCNAME[@]}"

    # count=0
    #     until false
    #     do
    #     ((count++))
    #     if [[ $count -eq 5 ]]
    #     then
    #         continue
    #     elif [[ $count -ge 10 ]]
    #     then
    #         break
    #     fi
    #     echo "Counter = $count"
    #     done
}


is_function_run_without_args() {
  # local tmp=${1:-.}

trace_full_call_stack

#   echo "${FUNCNAME[0]}"
#   echo "${FUNCNAME[1]}"
#   echo "${FUNCNAME[2]}"
#   echo "${FUNCNAME[3]}"

  local input="$1"
  local return_code="1"

  if ! [ "$input" -eq 0 ];
    then
      printf '%s\n' "[is_function_run_without_args] ${input} Function called with arguments"
      return_code="0"
      return "${return_code}"
    else
      printf '%s\n' "[is_function_run_without_args] ${input} Function called without arguments"
      return "${return_code}"
  fi

  printf '%s\n' "[is_function_run_without_args] ${input}"
  printf '%s\n' "Error: Failed to resolve validating whether or not input value is function called with arguments or not."
  
  # return "${return_code}"
  exit "${return_code}"
}


is_readable() {

  is_function_run_without_args "$#"
  
  local input="$1"
  local return_code="1"

    if [ -r "$input" ];
        then
            printf '%s\n' "[is_readable] ${input} Path is readable"
            return_code="0"
            return "${return_code}"
        else
            printf '%s\n' "[is_readable] ${input} Path not readable"
            return "${return_code}"
    fi

  printf '%s\n' "[is_readable] ${input}"
  printf '%s\n' "Error: Failed to resolve validating whether or not input value is readable path or not."
  
  # return "${return_code}"
  exit "${return_code}"
}


dir_exists() {
  local input="$1"
  local return_code="1"

  # [ $# -eq 0 ] && { echo "Usage: $0 dir-name"; exit 1; }
 
  if [ -d "$input" -a ! -h "$input" ]
    then
      printf '%s\n' "[dir_exists] ${input} Directory exists"
      return_code=0
      #return "${return_code}"
    else
      printf '%s\n' "[dir_exists] ${input} Directory not found or is symlink to $( readlink ${input} )"
      #return "${return_code}"
  fi

  printf '%s\n' "[dir_exists] ${input}"
  printf '%s\n' "Error: Failed to resolve validating whether or not input value is existing directory or not."
  exit "${return_code}"
}


# dir_exists "${INTERNAL_SCRIPTS_FILE_NAMES_ARRAY[0]}"
# echo "$?"

# dir_exists "dsds/${INTERNAL_SCRIPTS_FILE_NAMES_ARRAY[0]}"
# echo "$?"

is_readable
echo "$?"

is_readable "${INTERNAL_SCRIPTS_FILE_NAMES_ARRAY[0]}"
echo "$?"

# is_readable "dsds/${INTERNAL_SCRIPTS_FILE_NAMES_ARRAY[0]}"
# echo "$?"



#########################
# Shell scripting helpers
#########################

TYPES=(
  [0]="undefined" 
  [1]="null" 
  [2]="integer" 
  [3]="string" 
  [4]="float"
)

# generate_uuid() {
#   local input="$( od -x /dev/urandom | head -1 | awk '{OFS="-"; print $2$3,$4,$5,$6,$7$8$9}' )"
#   local return_code="1"

#   if [ -n "${input}" ]; then
#     echo "${input}"
#     return_code=0
#     return "${return_code}"
#   fi

#   printf '%s\n' "[generate_uuid] ${input}"
#   printf '%s\n' "Error: Failed to resolve generating UUID."
#   # return "${return_code}"
#   exit "${return_code}"
# }


# Verify argument count satisfies function call requirements
# Usage: require_args_count <ARG_COUNT_RECIEVED(typeof:"integer")> <MIN_ARG_COUNT_REQUIRED(typeof:"integer")> <EXIT_ON_ERROR(typeof:"integer")> <ERROR_MESSAGE(typeof:"string")>
#  - ARG_COUNT_RECIEVED = $# (default: 0)
#  - MIN_ARG_COUNT_REQUIRED = If "-1", min arg count is assumed to be 1 for function called, causing failure if no args are given. Else, provide min number. (default: -1) 
#  - EXIT_ON_ERROR = If "-1", causes immediate exit 1 on Error. If "1", causes return 1 on Error. <[negative/positive][integer]> not 1 uses that number instead. (default: -1)
#  - ERROR_MESSAGE = (default: "Error: [<FUNCTION_NAME>] Function expects argument count to be ")
#    Examples:
#     require_arg_count "$#" 
#     (^same as ^) require_arg_count "$#" "-1" "-1" "Error: [my_func] Function requires minimum argument count. Expects argument count: '>0' Recieved argument count: '0'. Exiting..." 
#
#     require_arg_count "$#" "3" "1" "Error: [my_func] Function requires minimum argument count. Expects argument count: '>0' Recieved argument count: '0'."
#     require_arg_count "5" ">8" "123" "Error: [my_func] Function requires minimum argument count. Expects argument count: '>0' Recieved argument count: '0'." 
#
#     Prefixing <MIN_ARG_COUNT_REQUIRED> with ">" is equiv to "<ARG_COUNT_RECIEVED> > <MIN_ARG_COUNT_REQUIRED>". "<ARG_COUNT_RECIEVED> >= <MIN_ARG_COUNT_REQUIRED>" is default behavior.

require_arg_count() {
  local UNIQUE_TOKEN="$( generate_uuid )" 

  local ARG_COUNT_TOTAL="$#"
  local FIRST_ARG_REF="$1"
  local SECOND_ARG_REF="$2"
  local THIRD_ARG_REF="$3"
  local FOURTH_ARG_REF="$4"

  local FIRST_ARG_FALLBACK_VALUE="${FIRST_ARG_REF:-$UNIQUE_TOKEN}"
  local SECOND_ARG_FALLBACK_VALUE="${SECOND_ARG_FALLBACK_VALUE:-'-1'}"
  local THIRD_ARG_FALLBACK_VALUE="${THIRD_ARG_FALLBACK_VALUE:-'-1'}"
  local FOURTH_ARG_FALLBACK_VALUE="${FOURTH_ARG_FALLBACK_VALUE:-'-1'}"

  local ARG_COUNT_RECIEVED_DEFAULT_VALUE="${ARG_COUNT_RECIEVED_DEFAULT_VALUE:-$FIRST_ARG_REF}"
  local MIN_ARG_COUNT_REQUIRE_DEFAULT_VALUE="${MIN_ARG_COUNT_REQUIRE:-$SECOND_ARG_REF}"
  local EXIT_ON_ERROR_DEFAULT_VALUE="${EXIT_ON_ERROR:-$THIRD_ARG_REF}"
  local ERROR_MESSAGE_DEFAULT_VALUE="${ERROR_MESSAGE:-$FOURTH_ARG_REF}"

  local DEFAULT_VALUES_ARRAY=(
     [0]="$ARG_COUNT_RECIEVED_DEFAULT_VALUE"
     [1]="$MIN_ARG_COUNT_REQUIRE_DEFAULT_VALUE"
     [2]="$EXIT_ON_ERROR_DEFAULT_VALUE"
     [3]="$ERROR_MESSAGE_DEFAULT_VALUE"
  )

  local ARG_COUNT_RECIEVED="${ARG_COUNT_RECIEVED:-$ARG_COUNT_RECIEVED_DEFAULT_VALUE}"
  local DEFAULT_PARAM_VALS=(
    [0]="$ARG_COUNT_RECIEVED"
    [1]=''
    [2]=''
    [3]=''    
  ) 

  let arg_count="${arg_count:-$UNIQUE_TOKEN}"

 if [ -n "${input}" ]; then
    echo "${input}"
    return_code=0
    return "${return_code}"
  fi

  let $# || { echo No arguments supplied; exit 1; }
}



is_undefined() {
    # FOO=${FOO:-'default value'}
# some-command "${FOO}"

  local UNIQUE_TOKEN="$( generate_uuid )"
  local FIRST_PARAM="$1"

  local input="${input:-$UNIQUE_TOKEN}"
  local return_code="0"

#   if [ "$input" = "$UNIQUE_TOKEN" ]; then
#       printf '%s\n' "[is_undefined] - ${input}"
#       printf '%s\n' "Error: Expected argument as value to check type of, but no value was given."
#       return "${return_code}"
#   else
#       if [ -z "${input+set}" ]; then
#         printf '%s\n' "${input}: [is_undefined] Value ${input} is type of ${TYPES[0]}"
#         return_code=1
#         return "${return_code}"
#       fi
#   fi

# printf '%s\n' "${input}"
# printf '%s\n' "${FIRST_PARAM}"

# if [ "$input" = "$UNIQUE_TOKEN" ]; then
#   if [ "$FIRST_PARAM" = "$UNIQUE_TOKEN" ]; then

#   fi
# fi

# if [ -z "${input-set}" ]; then
#         printf '%s\n' "${input}: [is_undefined] Value ${input} is type of ${TYPES[0]}"
#         return_code=1
#         return "${return_code}"
#       fi

#   printf '%s\n' "[is_undefined] Recieved: ${input}"
#   printf '%s\n' "Error: Failed to resolve checking type of value."
#   # return "${return_code}"
#   exit "${return_code}"
}

TypeOf() {
  local val_to_check
  val_to_check="${1}"

  local return_code
  return_code=0

  if [ -d "${dir_path}" ]; then
    printf '%s\n' "${dir_path}: [does_dir_exist] Directory ${dir_path} exists"
    return_code=1
    return "${return_code}"
  fi

 printf '%s\n' "${dir_path}: [does_dir_exist] Directory ${dir_path} does not exist"
 return "${return_code}"
}

# read -p "Type a number or a string: " input
# if [[ $input =~ ^[+-]?[0-9]+$ ]]; then
# echo "Input is an integer."

# elif [[ $input =~ ^[+-]?[0-9]+\.$ ]]; then
# echo "Input is a string."

# elif [[ $input =~ ^[+-]?[0-9]+\.?[0-9]*$ ]]; then
# echo "Input is a float."

# else
# echo "Input is a string."
# fi


# VAR1="Linuxize"
# VAR2="Linuxize"

# if [ "$VAR1" = "$VAR2" ]; then
#     echo "Strings are equal."
# else
#     echo "Strings are not equal."
# fi

# Split a string on a delimiter
# Usage: split "string" "delimiter"
# split "apples,oranges,pears,grapes" ","
# split "1, 2, 3, 4, 5" ", "
# split "hello---world---my---name---is---john" "---"
split() {
   IFS=$'\n' read -d "" -ra arr <<< "${1//$2/$'\n'}"
   printf '%s\n' "${arr[@]}"
}

# Get the directory name of a file path
# Usage: dirname "path"
# dirname ~/Pictures/Wallpapers/1.jpg
# dirname ~/Pictures/Downloads/
dirname() {
    local tmp=${1:-.}
    [[ $tmp != *[!/]* ]] && {
        printf '/\n'
        return
    }
    tmp=${tmp%%"${tmp##*[!/]}"}
    [[ $tmp != */* ]] && {
        printf '.\n'
        return
    }
    tmp=${tmp%/*}
    tmp=${tmp%%"${tmp##*[!/]}"}
    printf '%s\n' "${tmp:-/}"
}

# Remove duplicate array elements
# Usage: remove_array_dups "array"
# remove_array_dups 1 1 2 2 3 3 3 3 3 4 4 4 4 4 5 5 5 5 5 5
# arr=(red red green blue blue)
# remove_array_dups "${arr[@]}"
remove_array_dups() {
    declare -a tmp_array
    for i in "$@"; do
        [[ $i ]] && IFS=" " tmp_array["${i:- }"]=1
    done
    printf '%s\n' "${!tmp_array[@]}"
}


# Count files or directories in directory
# Usage: count /path/to/dir/*
#        count /path/to/dir/*/
# count ~/Downloads/*
# count ~/Downloads/*/
# count ~/Pictures/*.jpg
count() {
    printf '%s\n' "$#"
}




# Get the base-name of a file path
# Usage: basename "path" ["suffix"]
# basename ~/Pictures/Wallpapers/1.jpg
# basename ~/Pictures/Wallpapers/1.jpg .jpg
# basename ~/Pictures/Downloads/
file_basename() {
    local tmp
    tmp=${1%"${1##*[!/]}"}
    tmp=${tmp##*/}
    tmp=${tmp%"${2/"$tmp"}"}
    printf '%s\n' "${tmp:-/}"
}


# Get the list of functions in a script
# Usage: get_functions
get_functions() {
    IFS=$'\n' read -d "" -ra functions < <(declare -F)
    printf '%s\n' "${functions[@]//declare -f }"
}



# Check if a program is in the user's PATH
# There are 3 ways to do this and either one can be used.
# TODO:
#   hash executable_name &>/dev/null
#   command -v executable_name &>/dev/null
# As a test
is_bin_type_in_path() {
  local bin_name
  bin_name="${1}"

  local return_code
  return_code="${0}"

  if type -p "${bin_name}" &>/dev/null; then
    printf '%s\n' "${bin_name}: [is_bin_type_in_path - Success] Executable Found In PATH"
    return_code=0
    return "${return_code}"
  fi

  printf '%s\n' "${bin_name}: [is_bin_type_in_path - Fail] Executable Found In PATH"
  return_code=1
  return "${return_code}"
}

# As inverse of test
is_bin_type_not_in_path() {
  local bin_name
  bin_name="${1}"

  local return_code
  return_code="${0}"

  if ! type -p "${bin_name}" &>/dev/null; then
    printf '%s\n' "${bin_name}: [is_bin_type_not_in_path - Success] Executable NOT Found In PATH"
    return_code=0
    return "${return_code}"
  fi

  printf '%s\n' "${bin_name}: [is_bin_type_not_in_path - Fail] - Executable Found In PATH"
  return_code=1
  return "${return_code}"
}

# Exit early if program is not installed
exit_if_bin_type_not_installed() {
  local bin_name
  bin_name="${1}"

  local return_code
  return_code="${0}"

  if ! type -p "${bin_name}" &>/dev/null; then
    printf '%s\n' "${bin_name}: [exit_if_bin_type_not_installed] Binary not installed"
    printf '%s\n' "Error: "${bin_name}" is not installed. Exiting now."
    return_code=1
    return "${return_code}"
    exit "${return_code}"
  fi

  printf '%s\n' "${bin_name}: [exit_if_bin_type_not_installed] Binary is installed"
  return_code=0
  return "${return_code}"
}


does_dir_exist() {
  local dir_path
  dir_path="${1}"

  local return_code
  return_code=0

  if [ -d "${dir_path}" ]; then
    printf '%s\n' "${dir_path}: [does_dir_exist] Directory ${dir_path} exists"
    return_code=1
    return "${return_code}"
  fi

 printf '%s\n' "${dir_path}: [does_dir_exist] Directory ${dir_path} does not exist"
 return "${return_code}"
}