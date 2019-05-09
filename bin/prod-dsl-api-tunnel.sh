#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

LABEL="Prod DSL API tunnal"
LOCAL_PORT=8080
DEST_PORT=80
DEST_HOST="dsl-api-v2.digitalassetsdata.com"
BASTION_HOST="prod"

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT $BASTION_HOST

