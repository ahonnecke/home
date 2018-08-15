#!/bin/sh

# ACTION="flake8"
# # COMMAND="pipenv run flake8"
# COMMAND="pipenv run flake8 --select=B902,E,F,W,C90"

# MERGE=$(git rev-parse -q --verify MERGE_HEAD)

# if [[ $MERGE ]]; then
#     echo "This is a merge.... Skipping $ACTION"
# else
#     echo "This is not a merge.... $ACTION ing"
# fi

# if [[ ! $MERGE ]]; then
#     FILES=$(git diff --cached --name-status | \
#                 grep -v node_modules | \
#                 awk '$1 != "D" {print $2}' | \
#                 grep -E '[.]py$' \
#                 | grep -v migrations)


#     echo "#### $ACTION ing the following files: ######"
#     printf '%s\n' "${FILES[@]}"
#     echo "############################################"

#     [ "$NOCHECK" != "" ] \
#         || [ "$FILES" = "" ] \
#         || $COMMAND $FILES \
#         || exit 1
# fi
