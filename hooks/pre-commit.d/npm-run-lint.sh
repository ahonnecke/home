#!/bin/sh

cd client
FILES=`git diff --cached --name-status | grep -v package.json | grep -v node_modules | awk '$1 != "D" {print $2}' | grep -E '[.]js$'`
[ "$NOCHECK" != "" ] || [ "$FILES" = "" ] || npm run fix $FILES || exit 1
