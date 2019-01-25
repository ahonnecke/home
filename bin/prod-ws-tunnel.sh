#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


LOCAL_PORT=30535
# LOCAL_PORT=30111
LABEL="Prod websocket subscribers"
DEST_PORT=3000
BASTION_HOST="prod-bastion"

DEST_HOST=$(/Users/ahonnecke/bin/ecsName2IP.py prod-subscriber)
echo "Located host IP $DEST_HOST"

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT $BASTION_HOST
