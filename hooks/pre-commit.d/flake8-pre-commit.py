#!/usr/local/bin/python3

from subprocess import call, run, check_output

from git import Repo
from trepan.api import debug

action = "flake8"
command = ['pipenv', 'run', 'flake8', '--select=B902,E,F,W,C90']
repo_path = '/Users/ahonnecke/Code/repos/web/'

web_repo = Repo(repo_path)
git = web_repo.git


try:
    git.rev_parse('-q', '--verify', 'MERGE_HEAD')
    is_merge = True
except Exception as e:
    is_merge = False

if is_merge:
    print(f'This is a merge.... Skipping {action}')
else:
    print(f'This is not a merge.... Performing {action}')


def chunks(l, n):
    """Yield successive n-sized chunks from l."""
    for i in range(0, len(l), n):
        yield l[i:i + n]


if is_merge:
    print("This is a merge, let's not do anything, that sounds tiring")

modified = git.diff('--cached', '--name-only', '--diff-filter=M').split()
added = git.diff('--cached', '--name-only', '--diff-filter=A').split()
files = added + modified

ignores = ['node_modules', 'migrations']

for pattern in ignores:
    files = [x for x in files if not pattern in x]

files = [x for x in files if x[-3:] == '.py']

failures = {}

print(f'==== {action} ing the following files: ======')
for filepath in files:
    print(filepath)
    command.append(filepath)
    # print(' '.join(str(x) for x in command))
    out = run(command, capture_output=True)
    if out.returncode != 0:
        failures[filepath] = out
    command.pop()
print("============================================")

if len(failures):
    print("############## FAILURES ####################")
    for filepath, failure in failures.items():
        print(f'###### {filepath} #########')

    print("############################################")

exit(len(failures))
