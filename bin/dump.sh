#!/bin/bash

mv /tmp/production.sql /tmp/last-production.sql
echo "Dumping from production..."
~/bin/watch-dump.sh&
mysqldump --add-drop-database --databases havenly_app > /tmp/production.sql
