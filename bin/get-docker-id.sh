#!/bin/bash
docker inspect $(docker container ls | tail -n 1 | awk '{print $1}') | grep Id | awk '{print $2}' | sed -e 's/[",]//g'
