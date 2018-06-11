#!/usr/bin/env python3

import git

web_repo = git.Repo("/Users/ahonnecke/Code/repos/web/")

for remote in web_repo.remotes:
    remote.fetch()

branch = web_repo.active_branch
print(f'Active Branch: {branch.name}')

config_filename = "/Users/ahonnecke/Code/repos/web/.circleci/config.yml"

for x in range(0, 1):
    with open(config_filename, "a") as config_file:
        config_file.write(f'# {x} units warmer\n')
        config_file.close()

    web_repo.index.add([config_filename])
    web_repo.git.commit('-m', 'warming circleCI')
    web_repo.remotes.origin.push(refspec=f'{branch}:{branch}')
