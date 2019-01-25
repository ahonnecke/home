#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


while read i;
do echo $i | grep " line "
done
