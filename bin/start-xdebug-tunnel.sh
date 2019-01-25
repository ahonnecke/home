#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


ps aux | grep ssh | grep 9000 | grep vagrant > /dev/null

if [ $? -ne 0 ]; then
    # exit status was error, meaning that it's not running
    # start it
    echo "Tunnel was not open... Opening now..."
    echo
    echo "The password is 'vagrant' "

    #ssh -p 2222 vagrant@127.0.0.1 -R 9000:localhost:9000
    ssh -f -p 2222 vagrant@127.0.0.1 -R 9000:localhost:9000 -N
else
    echo "Tunnel was already open.  You're good to go."
fi
