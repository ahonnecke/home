#!/usr/bin/env python3

import argparse
import json
import os
import re
import time
from subprocess import call

import git
import requests

from github import Github, GithubException

parser = argparse.ArgumentParser(description='Update a library')

parser.add_argument(
    '-k',
    '--keep',
    action='store_true',
    default=False,
    help='Keep the local changes before performing update'
)
parser.add_argument(
    '-d',
    '--dryrun',
    action='store_true',
    default=False,
    help='Dry run the local changes but exit before building and PRing'
)
args = parser.parse_args()

GITHUBTOKEN = os.environ['SERVICEDADTOKEN']
ORGNAME = 'digital-assets-data'
REPONAME = 'web'
GITUSERNAME = 'ahonnecke'
DOCKERACCT = 'ahonnecke'
SRCREMOTE = 'upstream'
SRCBRANCH = 'master'
SRCPATH = f'{SRCREMOTE}/{SRCBRANCH}'
IMGBASENAME = 'dad-base-image'
BASEDOCKERPATH = 'docker/Dockerfile.base'
TESTDOCKERPATH = 'docker/Dockerfile.test'


def get_chrome_driver_version():
    chrome_url = 'http://chromedriver.storage.googleapis.com/LATEST_RELEASE'
    response = requests.get(chrome_url)
    return response.text.replace("'", "")


def get_bionic_version():
    bionic_url = 'https://registry.hub.docker.com/v1/repositories/ubuntu/tags'
    response = requests.get(bionic_url)
    json_data = json.loads(response.text)
    bionic_tags = list(filter(lambda x: 'bionic' in x['name'], json_data))
    return bionic_tags[-1:][0]['name']


def get_ubuntu_version():
    return "18.04"


current_file = os.path.realpath(__file__)
print(f'Invoked from {current_file}')

repo_path = os.path.dirname(os.path.dirname(os.path.dirname(current_file))) + '/'
print(f'Operating on repo: {repo_path}')

build_dir = os.path.dirname(os.path.dirname(os.path.dirname(repo_path))) + '/'
print(f'Build Dir: {build_dir}')

base_dockerfile = f'{repo_path}{BASEDOCKERPATH}'
test_dockerfile = f'{repo_path}{TESTDOCKERPATH}'

chrome_version = get_chrome_driver_version()
print(f'Latest chrome version {chrome_version}')

ubuntu_tag = get_bionic_version()
# ubuntu_tag = get_ubuntu_version()
print(f'Latest version {ubuntu_tag}')

ts = int(time.time())
tag = f'{IMGBASENAME}-{ubuntu_tag}-{chrome_version}-{ts}'
remote_tag = f'{GITUSERNAME}/{tag}'

repo_instance = git.Repo(repo_path)
git = repo_instance.git

if not args.keep:
    git.reset('--hard', SRCPATH)
    git.checkout(SRCPATH)

os.chdir(repo_path)
call(['git', 'fetch', '--all'])
git.fetch('--all')


def update_base_dockerfile(dockerfile):
    print('Updating the base dockerfile')
    with open(dockerfile, 'r') as reader:
        content = reader.read()
        content_new = re.sub(
            'FROM ubuntu:.* as chrome',
            r'FROM ubuntu:' + str(ubuntu_tag) + ' as chrome',
            content,
            flags=re.M
        )

    with open(dockerfile, "w") as writer:
        writer.write(content_new)
        writer.close()

    with open(dockerfile, 'r') as reader:
        content = reader.read()
        content_new = re.sub(
            'ADD http://chromedriver.storage.googleapis.com/.*/chromedriver_linux64.zip ',
            r'ADD http://chromedriver.storage.googleapis.com/' + str(chrome_version) + '/chromedriver_linux64.zip ',
            content,
            flags=re.M
        )

    with open(dockerfile, "w") as writer:
        writer.write(content_new)
        writer.close()


def update_test_dockerfile(dockerfile):
    print(f'Updating the test dockerfile to point at {remote_tag}')
    with open(dockerfile, 'r') as reader:
        content = reader.read()
        content_new = re.sub(
            f'FROM {DOCKERACCT}/.* as base',
            r'FROM ' + str(remote_tag) + ' as base',
            content,
            flags=re.M
        )

    with open(dockerfile, "w") as writer:
        writer.write(content_new)
        writer.close()


def create_new_branch(new_branch):
    # Delete it if it exists, not the most elegant solution
    try:
        git.branch('-D', new_branch)
    except BaseException:
        pass

    print(f'Creating a branch with the new info')
    git.checkout('-b', new_branch, SRCPATH)


create_new_branch(tag)
update_base_dockerfile(base_dockerfile)
update_test_dockerfile(test_dockerfile)

changedFiles = [item.a_path for item in repo_instance.index.diff(None)]
if True or changedFiles:
    print(f'There are local changes, branching from master to {tag}')

    repo_instance.index.add(changedFiles)

    if args.dryrun:
        print('Exiting... with local changes still in place')
        exit()

    print(f'Building a new docker image from {base_dockerfile} in {build_dir}')
    os.chdir(build_dir)
    call(["docker", "build", '-t', tag, '-f', base_dockerfile, '.'])

    print(f'Finished building, tagging {tag} as {remote_tag}')
    call(["docker", "tag", tag, remote_tag])

    print(f'Tagged {remote_tag}, pushing to docker hub')
    call(["docker", 'push', remote_tag])

    print(f'Comitting changes and pushing to {tag}')
    git.commit('-m', f'Committing scripted changes')
    git.push('-v', 'origin', tag)

    head = f'{GITUSERNAME}:{tag}'
    print(f'Opening PR to merge "{head}" into "{SRCBRANCH}"')

    try:
        g = Github(GITHUBTOKEN)
        org = g.get_organization(ORGNAME)
        repo_instance = org.get_repo(REPONAME)

        repo_instance.create_pull(
            title=f'Point Dockerfile.test at new base image {remote_tag}',
            body=f'Automatically created PR that points the tester dockerfile at the new base image that was created from update_base_image.py',
            base=SRCBRANCH,
            head=head
        )

    except GithubException as ghe:
        print("Failed to Create a PR")
        raise ghe

else:
    pass
    print("No local changes... bye")
    git.checkout(SRCBRANCH)
    git.reset('--hard', SRCPATH)
