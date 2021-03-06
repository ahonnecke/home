#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


sleep 5

ps aux | grep /dump.sh | grep -v grep > /dev/null
total=2319999999

while [ $? -eq 0 ]
do
    if [ -f /tmp/local.sql ]; then
        size=`ls -l /tmp/local.sql | awk '{print $5}'`
        echo $size > /tmp/dump-size

        percent=$(bc <<<"scale=4;($size/$total)*100")
        #percent=$(bc <<<"scale=1;($percent)*100")

        #procmd='printf %'$percent's |tr " " "="'
        format='%'$percent's'

        progress=$(printf "$format" |tr " " "=")

        echo -ne $progress" "$percent'%  \r\c'

        sleep 1
    fi

    ps aux | grep /dump.sh | grep -v grep > /dev/null

    if [ $? -eq 1 ]
    then
        echo -ne $progress" "$percent'%'
        echo

        echo "Dump complete"
        echo
        cp /tmp/dump-size /tmp/last-dump-size
        echo
        exit 0;
    fi
done
echo
