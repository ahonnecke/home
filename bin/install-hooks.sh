#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


cd .git/hooks/
rm pre-commit || true
wget https://raw.githubusercontent.com/ahonnecke/home/master/hooks/pre-commit

mkdir -p pre-commit.d
cd pre-commit.d
wget https://raw.githubusercontent.com/ahonnecke/home/master/hooks/pre-commit.d/pylint.py
wget https://raw.githubusercontent.com/ahonnecke/home/master/hooks/pre-commit.d/isort.py
wget https://raw.githubusercontent.com/ahonnecke/home/master/hooks/pre-commit.d/mypy.py
