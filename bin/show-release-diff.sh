#!/bin/bash

cd /Users/ahonnecke/Code/CAKE

git fetch --tags upstream > /dev/null
TAG=`git describe --abbrev=0 --tags`
URL="https://github.com/havenly/havenly-2.0/compare/$TAG...staging"

echo $URL

open $URL

cd /Users/ahonnecke/Code/API

git fetch --tags upstream > /dev/null
TAG=`git describe --abbrev=0 --tags`
URL="https://github.com/havenly/API/compare/$TAG...staging"

echo $URL

open $URL
