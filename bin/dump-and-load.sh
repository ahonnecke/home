#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


~/bin/dump.sh && ~/bin/load.sh
