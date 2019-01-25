#!/usr/bin/env bash

#
# This pre-commit hook checks that you havn't left and DONOTCOMMIT tokens in
# your code when you go to commit.
#
# To use this script copy it to .git/hooks/pre-commit and make it executable.
#
# This is provided just as an example of how to use a pre-commit hook to
# catch nasties in your code.

# Work out what to diff against, really HEAD will work for any established repository.
if git rev-parse --verify HEAD >/dev/null 2>&1
then
    against=HEAD
else
    # Initial commit: diff against an empty tree object
    against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
fi

FILES=$(git diff --cached --diff-filter=MA --name-only | grep -v deny-debug-pre-commit)

FAILS0=$(echo $FILES | xargs grep DONOTCOMMIT)
FAILS1=$(echo $FILES | xargs grep NOCOMMIT)
FAILS2=$(echo $FILES | xargs grep -e '^\+.*debug().*$')
FAILS3=$(echo $FILES | xargs grep -e '^\+.*show_trace.*$')

if [[ $FAILS0 ]] ; then
    echo "You have left DONOTCOMMIT in the following files, "
    echo "You can't commit until they have been removed."
    echo $FAILS0
    exit 1
fi
if [[ $FAILS1 ]] ; then
    echo "You have left NOCOMMIT in the following files, "
    echo "You can't commit until they have been removed."
    echo $FAILS1
    exit 1
fi
if [[ $FAILS2 ]] ; then
    echo "You have left debug() in the following files, "
    echo "You can't commit until they have been removed."
    echo $FAILS2
    exit 1
fi
if [[ $FAILS3 ]] ; then
    echo "You have left show_trace in the following files,"
    echo "You can't commit until they have been removed."
    echo $FAILS3
    exit 1
fi
exit 0

