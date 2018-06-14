#!/usr/bin/env python3

import json
import os
import re
from subprocess import call

import requests

import git
from github import Github, GithubException

response = requests.get('https://registry.hub.docker.com/v1/repositories/ubuntu/tags')
json_data = json.loads(response.text)
bionic_tags = list(filter(lambda x: 'bionic' in x['name'], json_data))
latest_tag = bionic_tags[-1:][0]['name']

print(f'Found bionic version {latest_tag}')

web_repo = git.Repo("/Users/ahonnecke/Code/repos/web-batch/")
git = web_repo.git
circlefile = "/Users/ahonnecke/Code/repos/web-batch/docker/Dockerfile.test"

for remote in web_repo.remotes:
    remote.fetch()

new_branch = f'bionic-version-{latest_tag}'

call(['git', 'fetch', '--all'])
git.fetch('--all')
remote_branches = git.branch('-r')

full = f'origin/{new_branch}'
if full in remote_branches:
    print(f'"{full}" already exists... bye')
    exit(0)

git.reset('--hard', 'upstream/master')
git.checkout('upstream/master')

g = Github(os.environ['SERVICEDADTOKEN'])

try:
    org = g.get_organization('digital-assets-data')
except GithubException as ghe:
    print(ghe)

try:
    # @todo: fid a better way to check for a branch
    git.branch('-D', new_branch)
except:
    pass

git.checkout('-b', new_branch, 'upstream/master')

with open(circlefile, 'r') as reader:
    content = reader.read()
    content_new = re.sub(
        'FROM ubuntu:.*',
        r'FROM ubuntu:' + str(latest_tag),
        content,
        flags=re.M
    )

with open(circlefile, "w") as writer:
    writer.write(content_new)
    writer.close()

changedFiles = [item.a_path for item in web_repo.index.diff(None)]
if changedFiles:
    web_repo.index.add(changedFiles)
    git.commit('-m', f'Updating bionic version to {latest_tag}')
    git.push('-v', 'origin', new_branch)

    base = "master"
    head = f'ahonnecke:{new_branch}'
    print(f'Opening PR to merge "{head}" into "{base}"')
    web_repo = org.get_repo('web')
    web_repo.create_pull(
        title=f'Update ccxt to version {latest_tag}',
        body="Scripted update for the bionic tag",
        base=base,
        head=head
    )
