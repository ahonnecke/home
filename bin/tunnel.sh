#!/usr/bin/env bash
LABEL=$1
echo "$LABEL"
LOCAL_PORT=$2

DEST_HOST=$3
DEST_PORT=$4

BASTION_HOST=$5
BASTION_USER="ubuntu"

if [ "$BASTION_HOST" = "dev-bastion" ]; then
    KEY="~/.ssh/manual-dev-web-bastion.pem"
fi

if [ "$BASTION_HOST" = "prod-bastion" ]; then
    KEY="~/.ssh/manual-prod-web-bastion.pem"
fi

nc -z localhost $LOCAL_PORT > /dev/null
if [ $? -ne 0 ]; then
    echo "$LABEL tunnel to $DEST_HOST not open...."
    echo "Opening localhost:$LOCAL_PORT >>>>> $DEST_HOST:$DEST_PORT (through $BASTION_USER@$BASTION_HOST)"


    which autossh
    if [ $? -eq 0 ]; then
        ssh-add -A

        echo "found autossh"
        autossh -M 0 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" \
                -L $LOCAL_PORT:$DEST_HOST:$DEST_PORT \
                $BASTION_USER@$BASTION_HOST
    else
        echo "===================== Did not find autossh ==========================="
        echo "If you are at galvanize platte "
        echo "they're going to kill your poor little connections if they get stale"
        echo "======================= Using ssh =============================="
        ssh -i $KEY -N -L \
            $LOCAL_PORT:$DEST_HOST:$DEST_PORT \
            $BASTION_USER@$BASTION_HOST&
    fi
else
    echo "Local port $LOCAL_PORT seems to be open...."

    ps aux | grep ssh | grep $LOCAL_PORT > /dev/null

    if [ $? -ne 0 ]; then
        echo "$LOCAL_PORT not an SSH tunnel..."
        echo "You probably need to try using a different port, this did not work"
        echo "Or kill whatever is on that port `netstat -anv | grep -i listen | grep $LOCAL_PORT`"
        exit 1
    fi

    echo "$LABEL tunnel to $DEST_HOST already open.  You're good to go."
    echo "localhost:$LOCAL_PORT >>>>> $DEST_HOST:$DEST_PORT (through $BASTION_USER@$BASTION_HOST)"
fi
