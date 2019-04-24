#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

LABEL="Dev DSL API tunnal"
LOCAL_PORT=8080
DEST_PORT=80
DEST_HOST="dsl-api-v2.da-data.net"
BASTION_HOST="dev"

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT $BASTION_HOST

