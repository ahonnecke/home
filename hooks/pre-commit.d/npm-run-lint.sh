#!/bin/sh

MERGE=$(git rev-parse -q --verify MERGE_HEAD)

if [[ $MERGE ]]; then
    echo "This is a merge.... Skipping npm lint"
    exit
else
    echo "This is not a merge.... npm linting"
fi


FILES=$(
    git diff --cached --name-only --diff-filter=MA \
        | grep -v node_modules \
        | grep -E '[.]js$'
     )

cd client

[ "$NOCHECK" != "" ] || [ "$FILES" = "" ] || npm run fix $FILES || exit 1
