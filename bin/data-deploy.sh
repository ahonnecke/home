#!/bin/bash

DIR="/Users/ahonnecke/Code/repos/clean-data-ingestion/"
FROM="master"
TO="dev"
REMOTE="origin"

URL="https://github.com/digital-assets-data/data-ingestion/compare/$TO...$FROM"
open $URL;

read -r -p "Promote $FROM to $TO? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
    cd $DIR

    git reset --hard $REMOTE/$TO --
    git checkout $FROM
    git reset --hard $REMOTE/$FROM --
    git push -v $REMOTE $FROM\:refs/heads/$TO
else
    echo "Cancelled deploy"
fi
