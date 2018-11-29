#!/bin/bash

LABEL=$1
echo "$LABEL"
LOCAL_PORT=$2

DEST_HOST=$3
DEST_PORT=$4

BASTION_HOST="dev-bastion"
BASTION_USER="ubuntu"
KEY="~/.ssh/manual-dev-web-bastion.pem"

nc -z localhost $LOCAL_PORT > /dev/null
if [ $? -ne 0 ]; then
    echo "$LABEL tunnel to $DEST_HOST not open...."
    echo "Opening localhost:$LOCAL_PORT >>>>> $DEST_HOST:$DEST_PORT (through $BASTION_USER@$BASTION_HOST)"

    ssh -i ~/.ssh/manual-dev-web-bastion.pem -N -L \
        $LOCAL_PORT:$DEST_HOST:$DEST_PORT \
        $BASTION_USER@$BASTION_HOST&
else
    echo "$LABEL tunnel to $DEST_HOST already open.  You're good to go."
fi
