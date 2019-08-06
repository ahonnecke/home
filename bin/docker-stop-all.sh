#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

docker stop $(docker ps -a -q)



