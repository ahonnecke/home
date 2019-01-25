#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

/Users/ahonnecke/Code/repos/infra-deploy/deploy.sh
