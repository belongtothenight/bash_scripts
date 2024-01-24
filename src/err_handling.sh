#!/bin/bash

set -eE -o functrace
failure () {
    local lineno=$1
    local bash_cmd=$2
    local bash_fun=$3
    local bash_src=$4
    echo "Failed at $lineno: $bash_src/$bash_fun/$bash_cmd"
}
trap 'failure "$LINENO" "$BASH_COMMAND" "$FUNCNAME" "$BASH_SOURCE"' ERR

func () {
    cat ./2
}

# continue if error while displaying error
conti_exe () {
    $1 || true
}

# retry if error while displaying error
retry_exe () {
    until echo 0; $1
    do sleep 1
    done
}

#cat ./1
conti_exe func
retry_exe func
echo "done"
