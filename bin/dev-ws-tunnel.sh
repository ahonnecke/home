#!/bin/bash

LOCAL_PORT=30011
LABEL="Dev websocket subscribers"
DEST_PORT=3000
BASTION_HOST="dev-bastion"

DEST_HOST=$(/Users/ahonnecke/bin/ecsName2IP.py dev-subscriber)
echo "Located host IP $DEST_HOST"

# nc -z localhost $LOCAL_PORT > /dev/null
# if [ $? -ne 0 ]; then
#     # exit status was error, meaning that it's not running
#     # start it
#     echo "Tunnel to $DEST_HOST not open...."
#     echo "Opening local:$LOCAL_PORT >>>>> $DEST_HOST:$DEST_PORT (through ubuntu@$BASTION_HOST)"

#     ssh -i ~/.ssh/manual-dev-web-bastion.pem -N -L \
#         $LOCAL_PORT:$DEST_HOST:$DEST_PORT ubuntu@$BASTION_HOST&
# else
#     echo "Tunnel to $LABEL already open.  You're good to go."
# fi

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT
