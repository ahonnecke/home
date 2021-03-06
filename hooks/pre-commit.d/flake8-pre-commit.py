#!/usr/local/bin/python3

import argparse
import os
import subprocess

from git import Repo

parser = argparse.ArgumentParser(description='Update a library')

# Get the path from the shell, which is the only way to get the
# location of the symlink src if it's called from a symlink
real_path = subprocess.check_output(['pwd']).decode("utf-8").rstrip()

parser.add_argument('-r', '--repo', help='Git Repository to operate on',
                    default=real_path)

args = parser.parse_args()
repo_path = args.repo

web_repo = Repo(repo_path)

git = web_repo.git

action = "flake8"
config_file = f'{repo_path}/setup.cfg'

if os.path.exists(config_file):
    command = ['pipenv', 'run', 'flake8', f'--config={config_file}']
else:
    exit(0)


try:
    git.rev_parse('-q', '--verify', 'MERGE_HEAD')
    is_merge = True
except Exception as e:
    is_merge = False

if is_merge:
    print(f'This is a merge.... Skipping {action}')
    exit(0)
else:
    print(f'This is not a merge.... Performing {action}')


def chunks(l, n):
    """Yield successive n-sized chunks from l."""
    for i in range(0, len(l), n):
        yield l[i:i + n]


modified = git.diff('--cached', '--name-only', '--diff-filter=M').split()
added = git.diff('--cached', '--name-only', '--diff-filter=A').split()
files = added + modified

ignores = ['node_modules', 'migrations']

for pattern in ignores:
    files = [x for x in files if not pattern in x]

files = [x for x in files if x[-3:] == '.py']

failures = {}

for filepath in files:
    # print(filepath)
    command.append(filepath)
    # print(' '.join(str(x) for x in command))
    out = subprocess.run(command, capture_output=True)
    if out.returncode != 0:
        failures[filepath] = out
    command.pop()

if len(failures):
    print("############## FAILURES ####################")
    for filepath, failure in failures.items():
        # print(f'###### {filepath} #########')
        print(failure.stdout.decode("utf-8").rstrip())

    print("############################################")

exit(len(failures))
