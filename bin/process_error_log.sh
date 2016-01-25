#!/bin/sh
tail -fn0 /Users/ahonnecke/Code/havenly-2.0/tmp/logs/error.log | while read line ; do
    echo "$line" | grep " Fatal Error "
    if [ $? = 0 ]
    then
        # Actions
        FILENAME=`echo "$line" | awk '{print $(NF-2)}' | sed -e 's/\[//' | sed -e 's/\,//'`
        LINENUMBER=`echo "$line" | awk '{print $NF}' | sed -e 's/\]//'`

        echo "Filename: $FILENAME";
        echo "Linenumber: $LINENUMBER";
        echo "emacsclient +$LINENUMBER $FILENAME &";
        emacsclient +$LINENUMBER $FILENAME &
    fi
done

# emacsclient --eval 'something that high'
