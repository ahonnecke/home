#!/bin/sh

FILES=$(git diff --cached --name-status | grep -v node_modules | awk '$1 != "D" {print $2}' | grep -E '[.]py$' | grep -v migrations)
[ "$NOCHECK" != "" ] || [ "$FILES" = "" ] || pipenv run mypy --ignore-missing-imports --strict-optional $FILES || exit 1
