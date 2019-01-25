#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


DIR="/Users/ahonnecke/Code/CAKE"
cd $DIR

git checkout staging
git reset --hard $(git describe --abbrev=0 --tags)

echo "$DIR is identical to most recent production tag"
echo "You can now apply your hotfix, Do you have a commit to cherry-pick?"
echo "(enter for none)"

read COMMIT

if [ ! -z "${COMMIT}" ]; then
    CHERRY="git cherry-pick $COMMIT"
    echo $CHERRY
    $CHERRY
    $COMMIT has been applied
    ~/bin/show-release-diff.sh
else
    echo "No commit applied $DIR is identical to most recent production tag"
    echo "Apply your hotfix and retag with production-deploy.sh"
fi
