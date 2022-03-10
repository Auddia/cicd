#!/usr/bin/env bash

#!/usr/bin/env bash

execute_for_each_space() {
  printf '%s\0' "${@:2}" |  xargs -0 -I % "$1" %
}

fail_if_empty_string() {
  if [ -z "$1" ];
  then
    exit 1
  fi
}