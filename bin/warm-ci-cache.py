#!/usr/bin/env python3

import os
import sys
from time import sleep

import git
from github import Github, GithubException


def ask_user(question):
    check = str(input(str(question) + " ? (Y/N): ")).lower().strip()
    try:
        if check[0] == 'y':
            return True
        elif check[0] == 'n':
            return False
        else:
            print('Invalid Input')
            return ask_user()
    except Exception as error:
        print("Please enter valid inputs")
        print(error)
        return ask_user(question)


if ask_user("Is it OK to crush the CI pipeline? (this will make it unusable for a while)"):
    print("Yeah! let's *DO THIS* (where 'this' is piss off devs)")
    delay = 10
else:
    print("OK Slow and steady wins the race... or some such bullshit")
    delay = 600


web_repo = git.Repo("/Users/ahonnecke/Code/repos/web-batch/")
git = web_repo.git


for remote in web_repo.remotes:
    remote.fetch()

git.checkout('master')
git.reset('--hard', 'upstream/master')

os.chdir("/Users/ahonnecke/Code/repos/web-batch/server")

g = Github(os.environ['SERVICEDADTOKEN'])

branch = web_repo.active_branch
print(f'Active Branch: {branch.name}')

cache_warmer_filename = "/Users/ahonnecke/Code/repos/web-batch/.cache-warmer"

g = Github(os.environ['SERVICEDADTOKEN'])

try:
    org = g.get_organization('digital-assets-data')
except GithubException as ghe:
    print(ghe)

new_branch = f'warm-ci-cache'

try:
    git.checkout(new_branch)
except:
    git.checkout('-b', new_branch, 'upstream/master')
    pass

# base = "master"
# head = f'ahonnecke:{new_branch}'
# print(f'Opening PR to merge "{head}" into "{base}"')
# web_repo = org.get_repo('web')
# web_repo.create_pull(
#     title=f'Warm up cache',
#     body="Scripted update to warm up the CI cache",
#     base=base,
#     head=head
# )

for x in range(0, 1):
    print(f'Pushing {x}...')
    with open(cache_warmer_filename, "a") as cache_warmer_file:
        cache_warmer_file.write(f'# {x} units warmer\n')
        cache_warmer_file.close()

    web_repo.index.add([cache_warmer_filename])
    git.commit('-m', f'warming cache')
    git.push('-v', 'origin', new_branch)

    # web_repo.index.add([cache_warmer_filename])
    # web_repo.git.commit('-m', 'warming circleCI')
    # web_repo.remotes.origin.push(refspec=f'{branch}:{branch}')
    print(f'Sleeping {delay} seconds after iteration {x}...')
    sleep(delay)
