#!/usr/bin/env bash

# TODO: WIP
execute_for_each_space() {
  printf '%s\0' "${@:2}" |  xargs -0 -I % bash -c "$1" % _
}

fail_if_empty_string() {
  if [ -z "$1" ];
  then
    exit 1
  fi
}

strings_equal() {
  s_one=$(echo "$1" | tr -d '[:space:]')
  s_two=$(echo "$2" | tr -d '[:space:]')

  if [ "$s_one" != "$s_two" ];
  then
    exit 1
  fi
}

strings_unequal() {
  s_one=$(echo "$1" | tr -d '[:space:]')
  s_two=$(echo "$2" | tr -d '[:space:]')

  echo $s_one
  echo $s_two

  if [ "$s_one" = "$s_two" ];
  then
    exit 1
  fi
}
