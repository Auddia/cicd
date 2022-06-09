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
  if [ "$1" != "$2" ];
  then
    exit 1
  fi
}

strings_unequal() {
  if [ "$1" = "$2" ];
  then
    exit 1
  fi
}
