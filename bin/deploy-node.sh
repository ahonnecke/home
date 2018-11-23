#!/bin/bash

cd ~/Code/repos/node-data-sync/docker
docker build -t dev-subscriber .
docker tag dev-subscriber:latest 712182686879.dkr.ecr.us-east-1.amazonaws.com/dev-subscriber:latest
$(aws ecr get-login --no-include-email --region us-east-1 --profile docker)
docker push 712182686879.dkr.ecr.us-east-1.amazonaws.com/dev-subscriber:latest
