#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


sed -i'' -e's/app.havenly.com/rewrite.havenly.local/g' /tmp/local.sql
#sed -i'' -e's/havenly.com/cms.havenly.local/g' /tmp/local.sql
sed -i'' -e's/havenly_app/CMS/g' /tmp/local.sql
