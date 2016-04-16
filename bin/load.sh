#!/bin/bash

echo Loading
pv ~/www/havenly/local-production.sql | mysql -h192.168.33.12 -uroot -proot CMS
mysql -h192.168.33.12 -uroot -proot CMS < /Users/ahonnecke/sql/scrub_personal_info.sql
echo Loaded
