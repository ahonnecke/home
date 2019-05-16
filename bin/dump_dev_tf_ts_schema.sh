#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Table must be provided";
    exit 8
else
    TABLE=$1
    echo "Dumping table $TABLE with limit $LIMIT";
fi

[[ "$TRACE" ]] && set -x
set -eu -o pipefail

LABEL="Dev Timeseries Database Container"
LOCAL_PORT=15438
DEST_PORT=5432
DEST_HOST="dev-web-postgresql.da-data.net"
BASTION_HOST="dev"

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT $BASTION_HOST

sleep 1

LIMIT=10001
USER='dev-app'
HOST='localhost'
DBNAME='postgres'

if (( LIMIT == 0 )); then
    echo "Dumping full table"
    pg_dump -t $TABLE\
            --data-only \
            -h $HOST -p $LOCAL_PORT -U $USER $DBNAME > ./$TABLE.sql
else
    echo "Dumping table schema"
    pg_dump -t $TABLE \
            -s \
            -h $HOST -p $LOCAL_PORT -U $USER $DBNAME > ./$TABLE-schema.sql

    #TODO, allow user to override this
    QUERY="SELECT * FROM $TABLE LIMIT $LIMIT"

    echo "Dumping partial table ($LIMIT rows)"
    psql -c "COPY ($QUERY) TO STDOUT;" \
         -h $HOST \
         -p $LOCAL_PORT \
         -U $USER $DBNAME > ./$TABLE.tsv
fi
