#!/usr/bin/env bash


source "$PWD/scripts/helpers/generate_uuid.sh"


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
