#!/bin/bash

echo Loading
#mysql -u root < /tmp/production.sql
pv /tmp/production.sql | mysql -u root
mysql -u root havenly_app < /Users/ahonnecke/sql/scrub_personal_info.sql
#mysql -u root havenly_app < /Users/ahonnecke/sql/change_stamps.sql
echo Loaded
