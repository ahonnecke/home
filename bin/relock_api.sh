#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

docker-compose -f ~/AutoDS/AutoDSApi/bin/docker-compose-api.yml \
               run lint pipenv run pipenv update && \
sudo chown -R "$USER":"$USER" ./*
