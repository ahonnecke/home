#!/bin/bash

ps aux | grep ssh | grep prod-web > /dev/null

if [ $? -ne 0 ]; then
    # exit status was error, meaning that it's not running
    # start it
    echo "Tunnel to the prod db not open... Opening now..."

    ssh -i ~/.ssh/manual-prod-web-bastion.pem -N -L \
        33067:prod-www-mysql.cyzmwokjasvx.us-east-1.rds.amazonaws.com:3306 \
        ubuntu@prod-bastion&
else
    echo "Tunnel was already open.  You're good to go."
fi
