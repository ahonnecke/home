#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


~/bin/production-deploy-app.sh
~/bin/production-deploy-api.sh
