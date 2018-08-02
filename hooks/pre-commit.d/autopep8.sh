#!/bin/sh

FILES=$(git diff --cached --name-status | grep -v node_modules | awk '$1 != "D" {print $2}' | grep -E '[.]py$' | grep -v migrations)
[ "$NOCHECK" != "" ] || [ "$FILES" = "" ] || flake8 --select=B902,E,F,W,C90 $FILES || exit 1
