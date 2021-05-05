#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

REPLICON_URL="https://na6.replicon.com/PanasonicNA/my/timesheet/"
DISPLAY=:1 firefox $REPLICON_URL
