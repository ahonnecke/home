#!/usr/bin/env bash
LABEL=$1
echo "$LABEL"
LOCAL_PORT=$2

DEST_HOST=$3
DEST_PORT=$4

BASTION_HOST=$5
BASTION_USER="ubuntu"

if [ "$BASTION_HOST" = "dev-web-bastion" ]; then
    KEY="~/.ssh/dev-web.pem"
    BASTION_HOST="dev-web-bastion"
fi

if [ "$BASTION_HOST" = "dev" ]; then
    KEY="~/.ssh/dev-web.pem"
    BASTION_HOST="dev-web-bastion"
fi

if [ "$BASTION_HOST" = "prod-web-bastion" ]; then
    KEY="~/.ssh/prod-web.pem"
    BASTION_HOST="prod-web-bastion"
fi

if [ "$BASTION_HOST" = "prod" ]; then
    KEY="~/.ssh/prod-web.pem"
    BASTION_HOST="prod-web-bastion"
fi


netstat -tuplen | grep 127.0.0.1 | grep $LOCAL_PORT
if [ $? -ne 0 ]; then
    echo "$LABEL tunnel to $DEST_HOST not open...."
    echo "Opening localhost:$LOCAL_PORT >>>>> $DEST_HOST:$DEST_PORT (through $BASTION_USER@$BASTION_HOST)"

    which autossh
    if [ $? -eq 0 ]; then

        echo "Found autossh, you're going to get shit done!"
        autossh -M 0 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" \
                -f \
                -i $KEY -N -L \
                $LOCAL_PORT:$DEST_HOST:$DEST_PORT \
                $BASTION_USER@$BASTION_HOST
    else
        echo "===================== Did not find autossh ==========================="
        echo "If you are at galvanize platte "
        echo "they're going to kill your poor little connections if they get stale"
        echo "======================= Using ssh =============================="
        ssh -i $KEY -N -L \
            $LOCAL_PORT:$DEST_HOST:$DEST_PORT \
            $BASTION_USER@$BASTION_HOST \
            &
    fi

    sleep 1
else
    echo "Local port $LOCAL_PORT seems to be open...."

    # Used to check for an ssh process that was on the local port
    netstat -tuplen | grep ssh | grep $LOCAL_PORT > /dev/null

    if [ $? -ne 0 ]; then
        echo "$LOCAL_PORT not an SSH tunnel..."
        echo "You probably need to try using a different port, this did not work"
        # #echo "Or kill whatever is on that port `netstat -anv | grep -i listen | grep $LOCAL_PORT`"
        exit 1
    fi

    echo "$LABEL tunnel to $DEST_HOST already open.  You're good to go."
    echo "localhost:$LOCAL_PORT >>>>> $DEST_HOST:$DEST_PORT (through $BASTION_USER@$BASTION_HOST)"
fi
