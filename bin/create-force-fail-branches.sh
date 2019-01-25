#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


cd ~/Code/repos/
BRANCH=`git rev-parse --abbrev-ref HEAD`

git fetch --all
git reset --hard
