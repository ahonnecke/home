#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


LABEL="Local Timeseries Database Container"
LOCAL_PORT=15434
DEST_PORT=5432
    DEST_HOST="10.65.0.26"
BASTION_HOST="dev-bastion"

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT $BASTION_HOST
