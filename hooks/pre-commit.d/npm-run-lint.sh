#!/bin/sh


FILES=$(
    git diff --cached --name-only --diff-filter=MA \
        | grep -v node_modules \
        | grep -E '[.]js$'
     )

[ "$NOCHECK" != "" ] || [ "$FILES" = "" ] || npm run fix $FILES || exit 1
