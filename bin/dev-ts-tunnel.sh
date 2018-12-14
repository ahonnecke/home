#!/bin/bash

LABEL="Dev Timeseries Database"
LOCAL_PORT=54320
DEST_PORT=5432
DEST_HOST="ip-10-65-31-246.ec2.internal"
BASTION_HOST="dev-bastion"

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT $BASTION_HOST
