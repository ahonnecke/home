#!/usr/bin/env python3.6

import os
from subprocess import PIPE, run

remote_client_keys = run(
    ['/usr/local/bin/aws', 's3', '--region', 'us-east-1', '--profile', 'web', 'ls', 's3://265040097070-dev-client-keys'],
    stdout=PIPE
).stdout.decode('utf-8').split("\n")

remote_client_ids = []
for remote_client_key in remote_client_keys:
    keyinfo = remote_client_key.split(' ')
    remote_client_ids.append(keyinfo[-1])

key_dir = "/Users/ahonnecke/client_keys"
local_client_keys = os.listdir(key_dir)

for remote in remote_client_ids:
    if remote and remote not in local_client_keys:
        remote_path = f's3://265040097070-dev-client-keys/{remote}'
        print(f'Copying {remote_path} to {key_dir}')
        copy_key = run(
            ['aws', 's3', '--region', 'us-east-1', '--profile', 'web',
             'cp', remote_path, key_dir]
        )
        print(f'Copied {remote_path} to {key_dir}')
