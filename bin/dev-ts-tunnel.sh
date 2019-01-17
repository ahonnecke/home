#!/bin/bash

LABEL="Dev Timeseries Database"
LOCAL_PORT=54320
DEST_PORT=5432
DEST_HOST="timescale.da-data.net"
BASTION_HOST="dev-bastion"

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT $BASTION_HOST
