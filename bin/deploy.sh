#!/bin/bash

WHERE="canary"
FROM="upstream/master"

read -r -p "What application would you like to deploy? [apP/apI/Cms] " response
if [[ $response =~ ^([pP])$ ]]
then
    WHAT="APP"
    cd ~/Code/CAKE
fi

if [[ $response =~ ^([iI])$ ]]
then
    WHAT="API"
    cd ~/Code/API
fi

if [[ $response =~ ^([cC])$ ]]
then
    WHAT="CMS"
    cd ~/Code/CMS
fi

read -r -p "Deploy $WHAT to $WHERE from $FROM? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
    ~/bin/ashbot.sh #sets the token

    slackcli --username="ashbot" \
             -h development \
             -m "Beginning a deploy of $WHAT to $WHERE from $FROM" \
             -i="http://pixelstub.com/images/robot_coral_small.png"

    git fetch --all
    git checkout $WHERE
    git reset --hard $FROM
    git push upstream $WHERE
fi
