#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail


unset CLIENT_KEY
unset PLAID_CLIENT_ID
unset PLAID_SECRET
unset PLAID_PUBLIC_KEY
unset LEDGER_API_HOST
unset CMC_API_HOST
unset EMAIL_PASSWORD
cd /Users/ahonnecke/Code/repos/web
DJANGO_SETTINGS_MODULE=dad.config.local
ENVIRON=local
./run-all-tests.sh
