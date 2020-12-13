#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

cp --no-clobber /mnt/largesse/hypemachine/* /media/NASty/music/HymenMachine
