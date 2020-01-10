#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

firefox https://meet.google.com/yqe-yjem-hek?authuser=1
