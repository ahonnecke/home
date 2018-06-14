#!/usr/bin/env python3

import json
import re

import requests
from trepan.api import debug

import git

exit()
# I think that this one is deprecated, but keeping around just in case

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

git.reset('--hard', 'upstream/master')
git.checkout('upstream/master')
try:
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
