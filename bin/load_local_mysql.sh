#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

DEFAULTVALUE="autodsapi"
DBNAME=${1:-$DEFAULTVALUE}
DUMPFILE="{$HOME}/data/${DBNAME}_dump.sql";

if [ ! -f "$DUMPFILE" ]; then
    echo "${DUMPFILE} does not exist"
    exit 1

fi

read -r -p \
     "Dump exists (at $DUMPFILE) Would you like me to load it into ${DBNAME} y/N? " \
     RESPONSE

if [[ $RESPONSE =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo "Reloading dump"
    mysql -uroot \
          -proot \
          -h 127.0.0.1 \
          --add-drop-database \
          --databases > "$DUMPFILE"
else
    echo "Leaving existing database {$DBNAME} alone"
fi
