#!/usr/bin/env python3

import re

import requests

import git

response = requests.get('http://chromedriver.storage.googleapis.com/LATEST_RELEASE')
chrome_version = response.text.replace("'", "")

print(f'Found chrome version {chrome_version}')

web_repo = git.Repo("/Users/ahonnecke/Code/repos/web-batch/")
git = web_repo.git
circlefile = "/Users/ahonnecke/Code/repos/web/.circleci/config.yml"

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
        '              --build-arg chromedriver_version=.*',
        r'              --build-arg chromedriver_version=' + str(chrome_version) + ' \\\\',
        content,
        flags=re.M
    )

with open(circlefile, "w") as writer:
    writer.write(content_new)
    writer.close()

changedFiles = [item.a_path for item in web_repo.index.diff(None)]
if changedFiles:
    web_repo.index.add(changedFiles)
    git.commit('-m', f'Updating chrome version to {chrome_version}')
    git.push('-v', 'origin', new_branch)
