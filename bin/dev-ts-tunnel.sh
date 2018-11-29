#!/bin/bash

LABEL="Dev Timeseries Database"
LOCAL_PORT=54320
DEST_PORT=5432
DEST_HOST=ip-10-0-143-126.ec2.internal

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT
