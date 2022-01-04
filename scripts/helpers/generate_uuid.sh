#!/usr/bin/env bash

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