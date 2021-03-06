#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

branch=`git rev-parse --abbrev-ref HEAD`
git show-branch -a 2>/dev/null | grep '\*' | grep -v "$branch" | head -n1 | sed 's/.*\[\(.*\)\].*/\1/' | sed 's/[\^~].*//'
