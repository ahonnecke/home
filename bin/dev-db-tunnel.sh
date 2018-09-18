#!/bin/bash

PORT=33065
nc -z localhost $PORT > /dev/null

if [ $? -ne 0 ]; then
    # exit status was error, meaning that it's not running
    # start it
    echo "Tunnel to the dev db not open... Opening now..."

    ssh -i ~/.ssh/manual-dev-web-bastion.pem -N -L \
        $PORT:dev-www-mysql.cyzmwokjasvx.us-east-1.rds.amazonaws.com:3306 \
        ubuntu@54.209.73.199&
else
    echo "Tunnel was already open.  You're good to go."
fi
