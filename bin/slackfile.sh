#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


slackcat -c development $1
