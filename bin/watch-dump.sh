#!/bin/bash

sleep 5

ps aux | grep /dump.sh | grep -v grep > /dev/null
total=$(cat /tmp/last-dump-size)

while [ $? -eq 0 ]
do
    size=`ls -l /tmp/production.sql | awk '{print $5}'`
    echo $size > /tmp/dump-size

    percent=$(bc <<<"scale=4;($size/$total)*100")
    #percent=$(bc <<<"scale=1;($percent)*100")

    #procmd='printf %'$percent's |tr " " "="'
    format='%'$percent's'

    progress=$(printf "$format" |tr " " "=")

    echo -ne $progress" "$percent'%  \r\c'
#    echo -ne $percent'%  '"\n"

    sleep 1

    ps aux | grep /dump.sh | grep -v grep > /dev/null

    if [ $? -eq 1 ]
    then
        echo -ne $progress" "$percent'%'
        echo
        echo "Dump complete"
        cp /tmp/dump-size /tmp/last-dump-size
        exit 0;
    fi
done
