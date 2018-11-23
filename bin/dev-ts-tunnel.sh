#!/bin/bash

PORT=54320
nc -z localhost $PORT > /dev/null

if [ $? -ne 0 ]; then
    # exit status was error, meaning that it's not running
    # start it
    echo "Tunnel to the dev timeseries db not open... Opening now..."

    ssh -i ~/.ssh/manual-dev-web-bastion.pem -N -L \
        $PORT:ip-10-0-143-126.ec2.internal:5432 \
        ubuntu@dev-bastion&
else
    echo "Tunnel was already open.  You're good to go."
fi


