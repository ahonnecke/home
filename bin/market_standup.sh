#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

google-chrome https://meet.google.com/yhe-misx-koa?authuser=1

