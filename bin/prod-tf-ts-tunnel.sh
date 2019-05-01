#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

LABEL="Prod Timescale HA Database Container"
LOCAL_PORT=15439
DEST_PORT=5432
DEST_HOST="ip-10-193-7-67.ec2.internal"
BASTION_HOST="prod"

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT $BASTION_HOST

sleep 1

pgcli -h localhost -p $LOCAL_PORT -U prod-app postgres
