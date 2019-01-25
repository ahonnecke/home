#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


PORT=63000
nc -z localhost $PORT > /dev/null

if [ $? -ne 0 ]; then
    # exit status was error, meaning that it's not running
    # start it
    echo "Tunnel to the ashbox not open... Opening now..."

    ssh -i ~/.ssh/manual-dev-web-bastion.pem -N -L \
        $PORT:ashbox.da-data.net:3001 \
        ubuntu@dev-bastion&
else
    echo "Tunnel was already open.  You're good to go."
fi
