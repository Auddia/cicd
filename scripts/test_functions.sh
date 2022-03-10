#!/usr/bin/env bash

#!/usr/bin/env bash

execute_for_each_space() {
  printf '%s\0' "${@:2}" |  xargs -0 -I % "$1" %
}