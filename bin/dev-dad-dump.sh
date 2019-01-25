#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


DUMPFILE="/tmp/dad-dev.sql"
FIXFILE="/Users/ahonnecke/sql/fix-dad-data.sql"

DEV_DB_NAME='dad'
LOCAL_DB_NAME='dev'

echo "Downloading raw dump from dev"

if [ -f $DUMPFILE ]; then
    read -r -p "Dump exists (at $DUMPFILE) Would you like me to remove and re-download it y/N " response
    if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo "Removing dump"
        rm $DUMPFILE
    else
        echo "Leaving existing dump alone"
    fi
fi

if [ ! -f $DUMPFILE ]; then

    /Users/ahonnecke/bin/dev-db-tunnel.sh

    echo "Confirmed Tunnel"
    echo "Dumping from $DEV_DB_NAME to $DUMPFILE"

    # It takes just a bit for the tunnel to set up.
    sleep 1

    mysqldump --add-drop-database -h127.0.0.1 -P33065  $DEV_DB_NAME > $DUMPFILE
fi

ls -l $DUMPFILE
echo "db dumped to $DUMPFILE"

mysql -uroot -proot -e "DROP DATABASE IF EXISTS $LOCAL_DB_NAME"
mysql -uroot -proot -e "CREATE DATABASE $LOCAL_DB_NAME"

echo "Done creating database"

mysql -uroot -proot $LOCAL_DB_NAME < $DUMPFILE

echo "Done loading dump"

mysql -uroot -proot $LOCAL_DB_NAME < $FIXFILE
