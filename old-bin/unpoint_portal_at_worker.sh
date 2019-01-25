#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


sudo sed -i '' '/10.10.100.43\ portal.csuglobal.edu/d' /etc/hosts
sudo sed -i '' '/10.10.100.43\ csuglobal.edu/d' /etc/hosts
