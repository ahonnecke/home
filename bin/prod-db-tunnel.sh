#!/bin/bash

    PORT=33067
nc -z localhost $PORT > /dev/null

if [ $? -ne 0 ]; then
    echo "Tunnel to the prod db not open... Opening now..."

    ssh -i ~/.ssh/manual-prod-web-bastion.pem -N -L \
        $PORT:prod-www-mysql.cyzmwokjasvx.us-east-1.rds.amazonaws.com:3306 \
        ubuntu@prod-bastion&
else
    echo "Tunnel was already open.  You're good to go."
fi
