#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


DIR="/Users/ahonnecke/Code/repos/data-ingestion/"
cd $DIR
FROM='master'
TO='dev'
URL="https://github.com/digital-assets-data/data-ingestion/compare/$FROM...$TO"

open $URL;

read -r -p "Deploy from $FROM to $TO? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
    git fetch -all
    echo "git push upstream $FROM:$TO"
else
    echo "Cancelled deploy"
fi
