import time

import requests

#replace me!!!
dsl_host = 'google.com'

global gone_start
global gone_end

gone_start = None
gone_end = None

down_start = None
down_end = None


def main():
    global gone_end
    global gone_start

    global down_end
    global down_start

    while True:
        try:
            response = requests.get(f'http://{dsl_host}/')

            if response.status_code == 200:
                if gone_end and not gone_start:
                    gone_end = time.time()

                if down_end and not down_start:
                    down_end = time.time()
                print(f'Got a 200 back from the healthcheck in {response.elapsed.total_seconds()} seconds')
            else:
                if not down_start:
                    down_start = time.time()

                print(f'Got a {response.status_code} back from the healthcheck')
        except requests.exceptions.ConnectionError:
            if not gone_start:
                gone_start = time.time()
            pass

        time.sleep(.1)


if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        if gone_start and gone_end:
            gonetime = gone_end - gone_start
        elif not gone_start:
            gonetime = 0
        elif not gone_end:
            gonetime = 'forever'

        print(f'Total gonetime: {gonetime}')

        if down_start and down_end:
            downtime = down_end - down_start
        elif not down_start:
            downtime = 0
        elif not down_end:
            downtime = 'forever'

        print(f'Total downtime: {downtime}')
