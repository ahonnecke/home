#!/usr/bin/env python3

import json
import subprocess

import requests

prod_rev = 'prod'
dev_rev = 'dev'
diff_url = f'https://github.com/digital-assets-data/bulk-hogan/compare/{prod_rev}...{dev_rev}'

subprocess.run(['firefox', diff_url])
