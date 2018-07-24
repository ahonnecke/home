#!/bin/bash

DUMPFILE="/tmp/dad-dev.sql"
FIXFILE="/Users/ahonnecke/sql/fix-dad-data.sql"

DEV_DB_NAME='dad'
LOCAL_DB_NAME='newdev'

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

fi

ll $DUMPFILE
echo "db dumped to $DUMPFILE"

mysql -uroot -proot -e "DROP DATABASE IF EXISTS $LOCAL_DB_NAME"
mysql -uroot -proot -e "CREATE DATABASE $LOCAL_DB_NAME"

echo "Done creating database"

mysql -uroot -proot $LOCAL_DB_NAME < $DUMPFILE

echo "Done loading dump"

mysql -uroot -proot $LOCAL_DB_NAME < $FIXFILE

# call([
#     'mysqldump',
#     '-h127.0.0.1',
#     '-udebug',
#     '-P33065',
#     '-p',
#     dev_db_name,
#     '>',
#     dump_file
# ])


# print(f'Dev DB dumped to {dump_file}')

# run_local_mysql_file(dump_file)

# print(f'local db loaded to {local_db_name} from {dump_file}')

# print(f'Fixing up data (from {fix_file}')

# run_local_mysql_file(fix_file)

# print('Done!')

#     mysqldump - uproduction - p$PW - P 3307 - h 127.0.0.1 - -add - drop - database \
#     - -databases havenly_app > $DUMPFILE

#     ~ / bin / fix - db.sh
# fi
