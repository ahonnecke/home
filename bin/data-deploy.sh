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

    # echo "git fetch --all"
    # git fetch --all
    # echo "git checkout $FROM"
    # git checkout $TO
    # echo "git reset --hard $REMOTE/$FROM"
    # git reset --hard $REMOTE/$FROM
    # echo "git push -v $REMOTE $FROM\:refs/heads/$TO"
    # git push -v $REMOTE $FROM\:refs/heads/$TO

    #TODO, parametrize
    git reset --hard origin/dev --
    git checkout master
    git reset --hard origin/master --
    git push -v origin master\:refs/heads/dev
else
    echo "Cancelled deploy"
fi
