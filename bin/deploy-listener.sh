#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

cd ~/Code/repos/infra-deploy
pipenv shell
cd scripts
python3 prepare_stacks.py dev
cd ..
sceptre launch-env dev
