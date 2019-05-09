#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


LOCAL_PORT=33067
LABEL="Prod database (MySQL web)"
DEST_HOST="prod-www-mysql.cyzmwokjasvx.us-east-1.rds.amazonaws.com"
DEST_PORT=3306
BASION_HOST="prod"

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT $BASION_HOST
