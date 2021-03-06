#!/usr/bin/env python3

import argparse
import os

PATH = '/Users/ahonnecke/Code/repos/websocket-listeners'


def get_args():
    parser = argparse.ArgumentParser(description='Rename symlink to use different config')

    parser.add_argument(
        'environment',
        choices=['local', 'dev', 'tunnel'],
        help='The environment to point node at'
    )

    return parser.parse_args()


def repoint(env):

    src = f'{PATH}/ormconfig.json'
    dest = f'{PATH}/ormconfig.{env}.json'
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
