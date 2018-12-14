#!/bin/bash

LABEL="Prod Timeseries Database"
LOCAL_PORT=54323
DEST_PORT=5432
DEST_HOST="ip-10-0-144-160.ec2.internal"
BASTION_HOST="prod-bastion"

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT $BASTION_HOST
