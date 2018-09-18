#!/usr/bin/env python3

import json

import requests
import subprocess

prod_hurl = 'https://app.digitalassetsdata.com/healthcheck/'
dev_hurl = 'https://dev.da-data.net/healthcheck/'

response = requests.get(prod_hurl)
json_data = json.loads(response.text)
prod_rev = json_data['revision']

response = requests.get(dev_hurl)
json_data = json.loads(response.text)
dev_rev = json_data['revision']
diff_url = f'https://github.com/digital-assets-data/web/compare/{prod_rev}...{dev_rev}'

subprocess.run(['open', diff_url])
