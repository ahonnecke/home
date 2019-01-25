#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


sudo echo "10.10.100.43 portal.csuglobal.edu" >> /etc/hosts
sudo echo "10.10.100.43 csuglobal.edu" >> /etc/hosts
