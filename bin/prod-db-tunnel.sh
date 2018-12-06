#!/bin/bash

LOCAL_PORT=33067
LABEL="Prod database (MySQL web)"
DEST_HOST="prod-www-mysql.cyzmwokjasvx.us-east-1.rds.amazonaws.com"
DEST_PORT=3306
BASION_HOST="prod-bastion"

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT $BASION_HOST
