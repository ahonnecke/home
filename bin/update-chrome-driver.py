#!/usr/bin/env python3

import os
import re
from subprocess import call

import requests

import git
from github import Github, GithubException

response = requests.get('http://chromedriver.storage.googleapis.com/LATEST_RELEASE')
chrome_version = response.text.replace("'", "")

print(f'Found chrome version {chrome_version}')

web_repo = git.Repo("/Users/ahonnecke/Code/repos/web-batch/")
git = web_repo.git
circlefile = "/Users/ahonnecke/Code/repos/web-batch/docker/Dockerfile.test"

g = Github(os.environ['SERVICEDADTOKEN'])

try:
    org = g.get_organization('digital-assets-data')
except GithubException as ghe:
    print(ghe)

new_branch = f'chrome-version-{chrome_version}'

git.reset('--hard', 'upstream/master')
git.checkout('upstream/master')

call(['git', 'fetch', '--all'])
git.fetch('--all')
remote_branches = git.branch('-r')

try:
    git.branch('-D', new_branch)
except:
    pass
git.checkout('-b', new_branch, 'upstream/master')

full = f'origin/{new_branch}'
if full in remote_branches:
    print(f'"{full}" already exists... bye')
    exit(0)

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

    base = "master"
    head = f'ahonnecke:{new_branch}'
    print(f'Opening PR to merge "{head}" into "{base}"')
    web_repo = org.get_repo('web')
    web_repo.create_pull(
        title=f'Update chrome-driver to version {chrome_version}',
        body="Scripted update for the chrome driver version",
        base=base,
        head=head
    )
