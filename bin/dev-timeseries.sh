#!/bin/bash

echo "strange_ceremony_hand"
/Users/ahonnecke/bin/dev-ts-tunnel.sh

sleep 1
/usr/local/bin/pgcli -h localhost -p 54320 -U postgres trades

sleep 1
