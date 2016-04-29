#!/bin/bash

cd /Users/ahonnecke/Code/CAKE

TAG=`git describe --abbrev=0 --tags`
URL="https://github.com/havenly/havenly-2.0/compare/$TAG...staging"

echo $URL

open $URL