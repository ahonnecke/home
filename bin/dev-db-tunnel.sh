#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


LOCAL_PORT=33065
LABEL="Dev database (MySQL web)"
DEST_HOST="dev-www-mysql.cyzmwokjasvx.us-east-1.rds.amazonaws.com"
DEST_PORT=3306
BASTION_HOST="dev"

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT $BASTION_HOST
