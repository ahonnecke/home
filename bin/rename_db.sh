#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


mysqlconn="mysql -u root -proot -h localhost"
olddb=$1
newdb=$2

echo "Renaming '$olddb' to '$newdb'"

$mysqlconn -e "CREATE DATABASE $newdb"
params=$($mysqlconn -N -e "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE table_schema='$olddb'")

for name in $params; do
    $mysqlconn -e "RENAME TABLE $olddb.$name to $newdb.$name";
done;

#$mysqlconn -e "DROP DATABASE $olddb"
