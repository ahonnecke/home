#!/usr/bin/env python3

import json
import os
import re
from subprocess import call, run
from time import sleep

dump_file = "/tmp/dad-dev.sql"
fix_file = "/Users/ahonnecke/sql/fix-dad-data.sql"

dev_db_name = 'dad'
local_db_name = 'dev'

print("==================== Downloading raw dump from dev ====================")

if os.path.isfile(dump_file):
    # prompt for delete file / redownload
    pass

if not os.path.isfile(dump_file):
    call(['/Users/ahonnecke/bin/dev-db-tunnel.sh'])

    print("==================== Confirmed Tunnel ====================")
    print(f'==================== Dumping from {dev_db_name} to {dump_file} ====================')

    # It takes just a bit for the tunnel to set up.
    sleep(1)

    call([
        'mysqldump',
        '--add-drop-database',
        '-h127.0.0.1',
        '-P33065',
        '-udebug',
        '-pdebug456\$',
        dev_db_name,
        '>',
        dump_file
    ])

call(['ls', '-l', dump_file])
print("==================== db dumped to dump_file ====================")

call(['mysql', '-uroot', '-proot', '-e', f'DROP DATABASE IF EXISTS {local_db_name}'])
call(['mysql', '-uroot', '-proot', '-e', f'CREATE DATABASE {local_db_name}'])

print("==================== Done creating database ====================")

run(['mysql', '-uroot', '-proot', local_db_name, '<', dump_file], shell=True)

print("==================== Done loading dump ====================")

call(['mysql', '-uroot', '-proot', local_db_name, '<', fix_file], shell=True)
