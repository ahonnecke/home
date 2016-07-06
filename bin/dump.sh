#!/bin/bash

DUMPFILE="/tmp/local.sql";

echo "Downloading raw dump of production..."
echo

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
    ~/bin/make-ro-tunnel.sh&

    echo "Dumping from production..."

    #~/bin/watch-dump.sh&

    PW=`cat /vagrant/src/api/config/autoload/local.php.production  \
        | grep password \
        | awk '{print $3}' \
        | sed -e "s/[',]//g"`

Mi    mysqldump -uproduction -p$PW -P 3307 -h 127.0.0.1 --add-drop-database \
              --databases havenly_app > $DUMPFILE

    ~/bin/fix-db.sh
fi
