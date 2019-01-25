#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


DIR="/Users/ahonnecke/Code/API"

cd $DIR

TAG=`git describe --abbrev=0 --tags`
URL="https://github.com/havenly/API/compare/$TAG...staging"

echo $URL

open $URL

read -r -p "Pull the trigger? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
    ~/bin/ashbot.sh #sets the token

    DATE=`date +"%Y%m%d%H%M"`
    TAG="release-$DATE"

    echo "Deploying $TAG to production"

    cd $DIR
    git fetch --all
    git checkout staging
    git reset --hard upstream/staging
    git tag $TAG
    git push upstream $TAG

    read -r -p "Do you want me to notify development? [y/N] " response
    if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        slackcli --username="ashbot" \
                 -h development \
                 -m "Deploying $TAG to production api" \
                 -i="http://pixelstub.com/images/robot_coral_small.png"
    fi

    read -r -p "Do you want me to notify general? [y/N] " response
    if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
    then

        slackcli --username="ashbot" \
                 -h general \
                 -m "Deploying $TAG to production api" \
                 -i="http://pixelstub.com/images/robot_coral_small.png"
    fi

    open https://rpm.newrelic.com/accounts/959945/applications/18411086
else
    echo "Cancelled deploy"
fi
