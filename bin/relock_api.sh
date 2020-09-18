#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

# We do this so that we can get sudo before locking
sudo ls > /dev/null && \
docker-compose -f ~/AutoDS/AutoDSApi/bin/docker-compose-api.yml \
               run lint pipenv run pipenv update && \
    sudo chown -R "$USER":"$USER" ~/AutoDS/AutoDSApi
