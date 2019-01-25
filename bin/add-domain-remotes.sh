#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

git remote add ahonnecke git@github.com:ahonnecke/DomainModel.git
git remote add wshafer git@github.com:wshafer/DomainModel.git
git remote add upstream git@github.com:havenly/DomainModel.git

git fetch --all
