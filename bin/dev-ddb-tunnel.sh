#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


export LABEL="Tunnel to dev document db"
export LOCAL_PORT=27018
export DEST_PORT=27017

export DEST_HOST=DEPLOY_ENV=${1:-"docdb-2019-02-14-17-15-03.cluster-cyzmwokjasvx.us-east-1.docdb.amazonaws.com"}

export DEST_HOST=DEPLOY_ENV=${1:-"dev-ingestion-binance-20190425182552950400000002.cluster-cyzmwokjasvx.us-east-1.docdb.amazonaws.com"}

#DEST_HOST="dev-ingestion-binance-20190425182552950400000002.cluster-cyzmwokjasvx.us-east-1.docdb.amazonaws.com"
export BASTION_HOST="dev-web-bastion"

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT $BASTION_HOST

~/bin/ddb_tunnel.sh v1SBiRq9DSHzgQ3oBiT8rPHZO6vIGRUG
