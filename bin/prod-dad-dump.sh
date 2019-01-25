#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


DUMPFILE="/tmp/dad-prod.sql"

PROD_DB_NAME='dad'
LOCAL_DB_NAME='prod'

echo "Downloading raw dump from prod"

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

    /Users/ahonnecke/bin/prod-db-tunnel.sh

    echo "Confirmed Tunnel"
    echo "Dumping from $PROD_DB_NAME to $DUMPFILE"

    # It takes just a bit for the tunnel to set up.
    sleep 1

    mysqldump --add-drop-database -h127.0.0.1 -P33067 $PROD_DB_NAME > $DUMPFILE
fi

ls -l $DUMPFILE
echo "db dumped to $DUMPFILE"

mysql -uroot -proot -e "DROP DATABASE IF EXISTS $LOCAL_DB_NAME"
mysql -uroot -proot -e "CREATE DATABASE $LOCAL_DB_NAME"

echo "Done creating database"

mysql -uroot -proot $LOCAL_DB_NAME < $DUMPFILE
