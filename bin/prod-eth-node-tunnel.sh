#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

LABEL="Prod Eth Node tunnel"
LOCAL_PORT=8545
DEST_PORT=8545
DEST_HOST="prod-eth-node"
BASTION_HOST="prod-node"

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT $BASTION_HOST

LABEL="Prod Eth Node tunnel"
LOCAL_PORT=8546
DEST_PORT=8546
DEST_HOST="prod-eth-node"
BASTION_HOST="prod-node"

~/bin/tunnel.sh "$LABEL" $LOCAL_PORT $DEST_HOST $DEST_PORT $BASTION_HOST
