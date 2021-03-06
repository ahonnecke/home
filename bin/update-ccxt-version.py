#!/usr/bin/env python3

import json
import os
from subprocess import call

import git
from github import Github, GithubException

web_repo = git.Repo("/Users/ahonnecke/Code/repos/web-batch/")
git = web_repo.git
lock_file_name = "/Users/ahonnecke/Code/repos/web-batch/Pipfile.lock"

for remote in web_repo.remotes:
    remote.update()

git.checkout('master')
git.reset('--hard', 'upstream/master')

os.chdir("/Users/ahonnecke/Code/repos/web-batch/server")

g = Github(os.environ['SERVICEDADTOKEN'])

try:
    org = g.get_organization('digital-assets-data')
except GithubException as ghe:
    print(ghe)

with open(lock_file_name) as lockfile:
    lock_data = lockfile.read()
    lockfile.close()

json_data = json.loads(lock_data)
raw_ccxt_version = json_data['default']['ccxt']['version']
current_ccxt_version = raw_ccxt_version.replace("'", "").replace('=', '')

print(f'Current CCXT version is {current_ccxt_version}')

# couldn't find a good library for pipenv
call(['pipenv', 'update', 'ccxt'])

with open(lock_file_name) as lockfile:
    lock_data = lockfile.read()
    lockfile.close()

json_data = json.loads(lock_data)
raw_ccxt_version = json_data['default']['ccxt']['version']
latest_ccxt_version = raw_ccxt_version.replace("'", "").replace('=', '')

print(f'Current CCXT version is {latest_ccxt_version}')

call(['git', 'fetch', '--all'])
git.fetch('--all')
remote_branches = git.branch('-r')

changedFiles = [item.a_path for item in web_repo.index.diff(None)]

if current_ccxt_version != latest_ccxt_version:
    print("Pipfile.lock has changed")
    new_branch = f'ccxt-{latest_ccxt_version}'

    full = f'origin/{new_branch}'
    if full in remote_branches:
        print(f'"{full}" already exists... bye')
        exit(0)

    try:
        git.branch('-D', new_branch)
    except:
        #         # @todo: find a better way to check for a branch
        # git.rev_parse('--verify', new_branch)
        pass

    git.checkout('-b', new_branch, 'upstream/master')

    web_repo.index.add(['Pipfile.lock'])
    git.commit('-m', f'Updating ccxt version')
    git.push('-v', 'origin', new_branch)

    base = "master"
    head = f'ahonnecke:{new_branch}'
    print(f'Opening PR to merge "{head}" into "{base}"')
    web_repo = org.get_repo('web')
    web_repo.create_pull(
        title=f'Update ccxt to version {latest_ccxt_version}',
        body="Scripted update for the CCXT library",
        base=base,
        head=head
    )
