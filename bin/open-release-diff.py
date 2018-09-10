#!/usr/bin/env python3

import json

import git
import requests
import subprocess

hurl = 'https://app.digitalassetsdata.com/healthcheck/'

response = requests.get(hurl)
json_data = json.loads(response.text)
dev_rev = json_data['revision']
diff_url = f'https://github.com/digital-assets-data/web/compare/{dev_rev}...HEAD'

subprocess.run(['open', diff_url])
