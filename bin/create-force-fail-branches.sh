#!/bin/bash

cd ~/Code/repos/
BRANCH=`git rev-parse --abbrev-ref HEAD`

git fetch --all
git reset --hard
