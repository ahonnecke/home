#!/bin/bash

i='CMS';

echo Loading
pv /tmp/local.sql | mysql -h192.168.33.12 -uroot -proot $i
echo Loaded
mysql -h vagrant -u root -proot $i < ~/sql/create-test-data.sql;
