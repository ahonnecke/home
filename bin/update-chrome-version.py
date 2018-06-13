#!/usr/bin/env python3

import json
import re

import requests
from trepan.api import debug

import git

response = requests.get('http://chromedriver.storage.googleapis.com/LATEST_RELEASE')

print(f'Found chrome version {chrome_version}')

web_repo = git.Repo("/Users/ahonnecke/Code/repos/web-batch/")
git = web_repo.git
circlefile = "/Users/ahonnecke/Code/repos/web-batch/docker/Dockerfile.test"

for remote in web_repo.remotes:
    remote.fetch()

new_branch = f'chrome-version-{chrome_version}'

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
        'ENV CHROME_DRIVER_VERSION .*',
        r'ENV CHROME_DRIVER_VERSION ' + str(chrome_version),
        content,
        flags=re.M
    )

    content_newer = re.sub(
        'ADD http://chromedriver.storage.googleapis.com/.*/chromedriver_linux64.zip ',
        r'ADD http://chromedriver.storage.googleapis.com/' + str(chrome_version) + '/chromedriver_linux64.zip ',
        content_new,
        flags=re.M
    )

with open(circlefile, "w") as writer:
    writer.write(content_newer)
    writer.close()

changedFiles = [item.a_path for item in web_repo.index.diff(None)]
if changedFiles:
    web_repo.index.add(changedFiles)
    git.commit('-m', f'Updating chrome version to {chrome_version}')
    git.push('-v', 'origin', new_branch)
