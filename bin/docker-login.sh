#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

exec $(aws ecr --profile nodes get-login --no-include-email --region us-east-1)



