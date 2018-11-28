#!/bin/bash

LOCAL_PORT=30001
LABEL="Dev websocket subscribers"
DEST_HOST="ashbox.da-data.net"
DEST_PORT=3000
BASTION_HOST="dev-bastion"
nc -z localhost $LOCAL_PORT > /dev/null

if [ $? -ne 0 ]; then
    # exit status was error, meaning that it's not running
    # start it
    echo "Tunnel to the $LABEL db not open... Opening now..."
    echo "$LOCAL_PORT:$DEST_HOST:$DEST_PORT ubuntu@$BASTION_HOST"

    ssh -i ~/.ssh/manual-dev-web-bastion.pem -N -L \
        $LOCAL_PORT:$DEST_HOST:$DEST_PORT ubuntu@$BASTION_HOST&
else
    echo "Tunnel to $LABEL already open.  You're good to go."
fi


