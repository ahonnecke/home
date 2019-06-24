#!/usr/bin/env python3

import os
import subprocess
import time

import psycopg2
import pyperclip
import requests

PG_HOST = os.environ.get('TUNNEL_DEV_PG_HOST', 'localhost')
PG_DB = os.environ.get('TUNNEL_DEV_PG_DB', 'postgres')
PG_USER = os.environ.get('TUNNEL_DEV_PG_USER', 'dev-app')
PG_PORT = os.environ.get('TUNNEL_DEV_PG_PORT')
PG_PW = os.environ.get('TUNNEL_DEV_PG_PW')

if __name__ == "__main__":
    # subprocess.run(["dev-tf-ts-tunnel.sh", "no"])

    con = psycopg2.connect(f'postgresql://{PG_USER}:{PG_PW}@{PG_HOST}:{PG_PORT}/{PG_DB}')
    # con.set_isolation_level(psycopg2.extensions.ISOLATION_LEVEL_AUTOCOMMIT)
    cursor = con.cursor()
    query = input('Raw Query: ')

    start = time.time()
    row = cursor.execute(f"EXPLAIN {query}")
    end = time.time()
    elapsed = end - start

    print(f'Bare EXPLAIN took {elapsed}')
    if elapsed > 2:
        print('EXPLAIN took too long, exiting')
        exit(1)

    print('Performing EXPLAIN ANALYZE')
    start = time.time()
    row = cursor.execute(f"EXPLAIN ANALYZE {query}")
    end = time.time()
    elapsed = end - start

    print(f'EXPLAIN ANALYZE took {elapsed}')

    results = [x[0] for x in cursor.fetchall()]
    plan = "\n".join(results)

    # print(plan)

    url = 'https://explain.depesz.com/'
    r = requests.post(url, data={'plan': plan})

    print(r.status_code, r.reason)

    location = (r.url)
    pyperclip.copy(location)

    print(location)

    subprocess.run(["google-chrome", location])
