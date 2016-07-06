#!/bin/bash

WHERE="staging"
FROM="upstream/canary"

read -r -p "What application would you like to deploy? [apP/apI/cmS] " response
if [[ $response =~ ^([pP])$ ]]
then
    WHAT="APP"
fi

if [[ $response =~ ^([iI])$ ]]
then
    WHAT="API"
fi

if [[ $response =~ ^([sS])$ ]]
then
    WHAT="CMS"
fi

cd ~/Code/$WHAT

git fetch --all
git checkout $WHERE
git pull

read -r -p "Deploy $WHAT to $WHERE from $FROM? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
    ~/bin/ashbot.sh #sets the token

    slackcli --username="ashbot" \
             -h development \
             -m "Beginning a deploy of $WHAT to $WHERE from $FROM" \
             -i="http://pixelstub.com/images/robot_coral_small.png"

    git reset --hard $FROM
    git push upstream $WHERE
fi
