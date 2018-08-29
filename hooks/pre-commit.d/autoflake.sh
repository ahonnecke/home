#!/bin/sh

ACTION="autoflake"
COMMAND="autoflake --in-place --remove-all-unused-imports --remove-unused-variables"

MERGE=$(git rev-parse -q --verify MERGE_HEAD)

if [[ $MERGE ]]; then
    echo "This is a merge.... Skipping $ACTION"
else
    echo "This is not a merge.... $ACTION ing"
fi

if [[ ! $MERGE ]]; then
    FILES=$(git diff --cached --diff-filter=MA --name-only | \
                grep -v node_modules | \
                grep -E '[.]py$' \
                | grep -v migrations)

    [ "$NOCHECK" != "" ] \
        || [ "$FILES" = "" ] \
        || $COMMAND $FILES \
        || exit 1
fi
