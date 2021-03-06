#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


LABEL="Prod Timeseries Database"
LOCAL_PORT=54323
DEST_PORT=5432
DEST_HOST="timescale.digitalassetsdata.com"
BASTION_HOST="prod-bastion"

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT $BASTION_HOST
