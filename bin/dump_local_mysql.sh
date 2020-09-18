#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

DEFAULTVALUE="autodsapi"
DBNAME=${1:-$DEFAULTVALUE}

DUMPFILE="{$HOME}/data/${DBNAME}_dump.sql";

if [ -f "$DUMPFILE" ]; then
    # The dumpfile already exists, ask the user if we should clobber it
    read -r -p \
         "Dump exists (at $DUMPFILE) Would you like me to remove and re-download it y/N? " \
         RESPONSE

    if [[ $RESPONSE =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo "Removing dump"
        rm "$DUMPFILE"
    else
        echo "Leaving existing dump alone"
    fi
fi

if [ ! -f "$DUMPFILE" ]; then
    echo "Dumping from ${DBNAME} to ${DUMPFILE}..."

    mysqldump -uroot \
              -proot \
              -h 127.0.0.1 \
              --add-drop-database \
              --databases > "$DUMPFILE"
fi
