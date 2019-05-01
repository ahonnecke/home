#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

LABEL="Dev Timeseries Database Container"
LOCAL_PORT=15438
DEST_PORT=5432
DEST_HOST="dev-web-postgresql.da-data.net"
BASTION_HOST="dev"

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT $BASTION_HOST

sleep 1

pgcli -h localhost -p 15438 -U dev-app postgres
