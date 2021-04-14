#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

STANDUP_ID=$1
STANDUP_URL="https://zoom.us/j/$STANDUP_ID"

DISPLAY=:1 firefox $STANDUP_URL
