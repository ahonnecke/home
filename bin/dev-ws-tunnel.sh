#!/bin/bash

LOCAL_PORT=30535
# LOCAL_PORT=30111
LABEL="Dev websocket subscribers"
DEST_PORT=3000
BASTION_HOST="dev-bastion"

DEST_HOST=$(/Users/ahonnecke/bin/ecsName2IP.py dev-subscriber)
echo "Located host IP $DEST_HOST"

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT
