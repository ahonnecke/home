#!/bin/bash

cd /Users/ahonnecke/Code/DomainModel

git fetch --all
git pull
git checkout master
git reset --hard upstream/master

OLDTAG=`git tag | sort -t. -k1,1n -k2,2n -k3,3n | tail -n 1`
NEWTAG=`echo $OLDTAG | perl -pe 's/^((\d+\.)*)(\d+)(.*)$/$1.($3+1).$4/e'`

echo
echo "What's the new tag? (enter for $NEWTAG):"

read TAG

if [ -z "${TAG}" ]; then
    TAG=$NEWTAG
fi

MAKETAG="git tag -a $TAG -m 'tagman'"
PUSHTAG="git push upstream $TAG"

echo $MAKETAG
echo $PUSHTAG

echo "Confirm?"

read GOTIME

if [ -z "${GOTIME}" ]; then
    echo $MAKETAG
    $MAKETAG
    echo $PUSHTAG
    $PUSHTAG

    SLACK_TOKEN=xoxp-3255517620-14186594246-18207026423-9094019553
    slackcli --username="ashbot" -h development -m "Tagging doctrine ($TAG)" \
             -i="http://pixelstub.com/images/robot_coral_small.png"
fi
