#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


LOCAL_PORT=30001
LABEL="Dev websocket subscribers"
DEST_HOST="ashbox.da-data.net"
DEST_PORT=3000
BASTION_HOST="dev-bastion"

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT $BASTION_HOST
