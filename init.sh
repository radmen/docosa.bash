#!/bin/bash
# vim: set ft=sh

_docoseal_complete () {
  local cur=${COMP_WORDS[COMP_CWORD]}
  local available_commands="env exec logs purge reset run start stop"

  COMPREPLY=( $(compgen -W "$available_commands" -- $cur) )
}

complete -F _docoseal_complete docoseal

declare -r DIR="$(dirname ${BASH_SOURCE[0]})"

if test -d "${DIR}/bin"; then
  export PATH="${PATH}:${DIR}/bin"
else
  echo "Couldn't locate binaries directory"
fi
