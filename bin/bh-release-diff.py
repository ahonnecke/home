#!/usr/bin/env python3

import json

import requests
import subprocess

prod_rev = 'prod'
dev_rev = 'dev'
diff_url = f'https://github.com/digital-assets-data/bulk-hogan/compare/{prod_rev}...{dev_rev}'

subprocess.run(['open', diff_url])
