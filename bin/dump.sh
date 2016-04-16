#!/bin/bash

mv ~/www/havenly/production.sql ~/www/havenly/last-production.sql

#echo "Dropping database"
#mysql -u root -e "drop database havenly_app;"
#mysql -u root -e "create database havenly_app;"
#echo "Rebuilding schema..."
#mysqldump --no-data --databases havenly_app > /Users/ahonnecke/sql/havenly_app.sql
#mysql -u root havenly_app < /Users/ahonnecke/sql/havenly_app.sql

echo "Dumping from production..."
~/bin/watch-dump.sh&
mysqldump --add-drop-database --databases havenly_app > /tmp/production.sql
mv /tmp/production.sql ~/www/havenly/production.sql
~/bin/fix-db.sh
