#!/bin/sh

# FILES=`git diff --cached --name-status | grep -v node_modules | awk '$1 != "D" {print $2}' | grep -E '[.]py$' | grep -v migrations`
# [ "$NOCHECK" != "" ] || [ "$FILES" = "" ] || pylint --rcfile=~/.pylintrc server/portfolio_manager/models.py  $FILES || exit 1
