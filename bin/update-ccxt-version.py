#!/usr/bin/env python3

import os
import time
from subprocess import call

import git
# @todo use this library to create a PR
from github import Github

web_repo = git.Repo("/Users/ahonnecke/Code/repos/web-batch/")
git = web_repo.git

for remote in web_repo.remotes:
    remote.fetch()

git.checkout('master')
git.reset('--hard', 'upstream/master')

os.chdir("/Users/ahonnecke/Code/repos/web-batch/server")

# couldn't find a good library for pipenv
call(['pipenv', 'update', 'ccxt'])

changedFiles = [item.a_path for item in web_repo.index.diff(None)]

print(changedFiles)

if 'Pipfile.lock' in changedFiles:
    print("Pipfile.lock has changed")
    # @todo: add the version to the branch name
    epoch = time.time()
    new_branch = f'ccxt-update{epoch}'

    try:
        git.branch('-D', new_branch)
    except:
        pass

    git.checkout('-b', new_branch, 'upstream/master')

    web_repo.index.add(['Pipfile.lock'])
    git.commit('-m', f'Updating ccxt version')
    git.push('-v', 'origin', new_branch)

    # g = Github("ashton@pixelstub.com", "eat-sleep-code1")

    # for repo in g.get_user().get_repos():
    #     print(repo.name)
