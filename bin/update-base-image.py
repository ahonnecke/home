#!/usr/bin/env python3

import json
import os
import re
from subprocess import call

import requests

import git
from github import Github, GithubException


def get_chrome_driver_version():
    response = requests.get('http://chromedriver.storage.googleapis.com/LATEST_RELEASE')
    return response.text.replace("'", "")


def get_bionic_version():
    response = requests.get('https://registry.hub.docker.com/v1/repositories/ubuntu/tags')
    json_data = json.loads(response.text)
    bionic_tags = list(filter(lambda x: 'bionic' in x['name'], json_data))
    return bionic_tags[-1:][0]['name']


docker_tag = "ahonnecke/dad-base"
base_dockerfile = "/Users/ahonnecke/Code/repos/web-batch/docker/Dockerfile.base"

chrome_version = get_chrome_driver_version()
print(f'Latest chrome version {chrome_version}')

bionic_tag = get_bionic_version()
print(f'Latest bionic version {bionic_tag}')

web_repo = git.Repo("/Users/ahonnecke/Code/repos/web-batch/")
git = web_repo.git

git.reset('--hard', 'upstream/master')
git.checkout('upstream/master')

call(['git', 'fetch', '--all'])
git.fetch('--all')

with open(base_dockerfile, 'r') as reader:
    content = reader.read()
    content_new = re.sub(
        'FROM ubuntu:.*',
        r'FROM ubuntu:' + str(bionic_tag),
        content,
        flags=re.M
    )

with open(base_dockerfile, "w") as writer:
    writer.write(content_new)
    writer.close()

with open(base_dockerfile, 'r') as reader:
    content = reader.read()
    content_new = re.sub(
        'ADD http://chromedriver.storage.googleapis.com/.*/chromedriver_linux64.zip ',
        r'ADD http://chromedriver.storage.googleapis.com/' + str(chrome_version) + '/chromedriver_linux64.zip ',
        content,
        flags=re.M
    )

with open(base_dockerfile, "w") as writer:
    writer.write(content_new)
    writer.close()

changedFiles = [item.a_path for item in web_repo.index.diff(None)]
if changedFiles:
    call(["docker", "build", f"-t {docker_tag}", f' -f{base_dockerfile}'])
    call(["docker", f"push {docker_tag}"])
    print("There are local changes, building a new docker image")

else:
    print("No local changes... bye")
