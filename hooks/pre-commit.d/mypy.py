#!/usr/local/bin/python3

import argparse
# from pylint import Run
from subprocess import check_output, run

from git import Repo

parser = argparse.ArgumentParser(description='Update a library')

# Get the path from the shell, which is the only way to get the
# location of the symlink src if it's called from a symlink
real_path = check_output(['pwd']).decode("utf-8").rstrip()

parser.add_argument('-r', '--repo', help='Git Repository to operate on',
                    default=real_path)

args = parser.parse_args()
repo_path = args.repo

web_repo = Repo(repo_path)
git = web_repo.git

action = "mypy"
command = ['pipenv', 'run', 'mypy', '--ignore-missing-imports', '--strict-optional']

is_merge: bool
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
    files = [x for x in files if pattern not in x]

files = [x for x in files if x[-3:] == '.py']

failures = {}

for filepath in files:
    # print(filepath)
    command.append(filepath)
    # print(' '.join(str(x) for x in command))
    out = run(command, capture_output=True)
    if out.returncode != 0:
        failures[filepath] = out
    command.pop()

if len(failures):
    print("############## FAILURES ####################")
    for filepath, failure in failures.items():
        print(failure.stdout.decode("utf-8").rstrip())

    print("############################################")

exit(len(failures))
