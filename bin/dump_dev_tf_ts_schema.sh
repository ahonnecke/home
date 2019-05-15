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

    # -t blockchain_aggregate_block_day \
    # -t blockchain_aggregate_block_hour \
    # -t blockchain_aggregate_transaction_day \
    # -t blockchain_aggregate_transaction_hour \
    # -t trade_aggregate_all_usd_day \
    # -t trade_aggregate_all_usd_hour \
    # -t trade_aggregate_exchange_usd_hour \
    # -t trade_aggregate_exchange_usd_day \
    # -t trade_aggregate_exchange_usd_day \

TABLE='trade_raw_tick'
LIMIT=10001

if (( LIMIT == 0 )); then
    echo "Dumping full table"
    pg_dump -t $TABLE\
            --data-only \
            -h localhost -p $LOCAL_PORT -U dev-app postgres > ./$TABLE.sql
else
    echo "Dumping partial table ($LIMIT rows)"
    psql -c "COPY (SELECT * FROM $TABLE LIMIT $LIMIT) TO STDOUT;" \
         -h localhost \
         -p $LOCAL_PORT \
         -U dev-app postgres > ./$TABLE.sql
fi
