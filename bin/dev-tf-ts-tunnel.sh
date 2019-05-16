#!/usr/bin/env bash
JUST_TUNNEL=$1

[[ "$TRACE" ]] && set -x
set -eu -o pipefail

LABEL="Dev Timeseries Database Container"
LOCAL_PORT=15438
DEST_PORT=5432
DEST_HOST="dev-web-postgresql.da-data.net"
BASTION_HOST="dev"

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT $BASTION_HOST

if [ -z $JUST_TUNNEL ]; then
    echo "JUST_TUNNEL is unset, connecting";
    sleep 1
    pgcli -h localhost -p $LOCAL_PORT -U dev-app postgres
else
    echo "JUST_TUNNEL is set ($JUST_TUNNEL), exiting";
fi
