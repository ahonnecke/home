#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

LABEL="Dev DSL API tunnal"
LOCAL_PORT=8081
DEST_PORT=80
DEST_HOST="dsl-api-v2.da-data.net"
DEST_HOST="ip-10-65-5-168.ec2.internal"
BASTION_HOST="dev"

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT $BASTION_HOST

