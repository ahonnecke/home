#!/usr/bin/env python3

import argparse
import os


def get_args():
    parser = argparse.ArgumentParser(description='Rename symlink to use different config')

    parser.add_argument(
        'environment',
        choices=['local', 'dev', 'tunnel'],
        help='The environment to point node at'
    )

    return parser.parse_args()


def repoint(env):
    path = '/Users/ahonnecke/Code/repos/node-data-sync'
    src = f'{path}/ormconfig.json'
    dest = f'{path}/ormconfig.{env}.json'
    print(f'###############################################################')
    print(f'{src}')
    print(f'     Now points to ------------>    ')
    print(f'{dest}')
    print(f'###############################################################')
    if os.path.isfile(src):
        print(f'\n### Removing {src} ###')
        os.unlink(src)
    os.symlink(dest, src)


if __name__ == "__main__":
    args = get_args()
    env = args.environment.lower()
    print(f'\n################## Pointing node at {env} #####################')
    repoint(env)
