#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


LABEL="Tunnel to dev document db"
LOCAL_PORT=27017
DEST_PORT=27017
DEST_HOST="docdb-2019-02-14-17-15-03.cluster-cyzmwokjasvx.us-east-1.docdb.amazonaws.com"
BASTION_HOST="dev-bastion"

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT $BASTION_HOST
