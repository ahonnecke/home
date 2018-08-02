#!/bin/sh

MERGE=$(git rev-parse -q --verify MERGE_HEAD)

FILES=$(git diff --cached --name-status | \
            grep -v node_modules | \
            awk '$1 != "D" {print $2}' | \
            grep -E '[.]py$' \
            | grep -v migrations)

if [ -n "$MERGE" ]; then
    [ "$NOCHECK" != "" ] \
        || [ "$FILES" = "" ] \
        || pipenv run mypy --ignore-missing-imports --strict-optional $FILES \
        || exit 1
fi
