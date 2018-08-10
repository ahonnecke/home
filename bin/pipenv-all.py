#!/usr/local/bin/python3

import argparse
import glob
import os
from subprocess import run

parser = argparse.ArgumentParser(description='Recursively perform file fixings')
parser.add_argument('command', help='Command to run')
parser.add_argument('-d', '--dir', help='Base directory',
                    default='/Users/ahonnecke/Code/repos/web/server/')
parser.add_argument('-e', '--extenstion', help='File extenstion to operate on',
                    default='py')
args = parser.parse_args()

base_dir = args.dir
pipenv = ['pipenv', 'run', args.command]

os.chdir(base_dir)

files = glob.glob(f'{base_dir}/**/*.{args.extenstion}', recursive=True)

ignore_me = ['migrations', '__init__']

for pattern in ignore_me:
    files = [x for x in files if not pattern in x]

for filename in files:
    pipenv.append(filename)
    print(' '.join(str(x) for x in pipenv))
    run(pipenv)
    pipenv.pop()
