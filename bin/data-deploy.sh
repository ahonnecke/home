#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


DIR="/Users/ahonnecke/Code/repos/clean-data-ingestion/"
FROM="master"
TO="dev"
REMOTE="upstream"

URL="https://github.com/digital-assets-data/data-ingestion/compare/$TO...$FROM"
open $URL;

read -r -p "Promote $FROM to $TO? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
    cd $DIR

    git checkout $to
    git reset --hard $REMOTE/$FROM --
    git push -v $REMOTE $FROM\:refs/heads/$TO
else
    echo "Cancelled deploy"
fi
