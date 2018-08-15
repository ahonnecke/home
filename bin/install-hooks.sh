#!/bin/bash

cd .git/hooks/
mkdir pre-commit.d
rm pre-commit
wget https://raw.githubusercontent.com/ahonnecke/home/master/hooks/pre-commit

cd pre-commit.d
wget https://raw.githubusercontent.com/ahonnecke/home/master/hooks/pre-commit.d/pylint.py
wget https://raw.githubusercontent.com/ahonnecke/home/master/hooks/pre-commit.d/isort.py
wget https://raw.githubusercontent.com/ahonnecke/home/master/hooks/pre-commit.d/mypy.py
