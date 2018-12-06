#!/usr/bin/env python3

import os
import shutil

DIR = os.path.abspath('/Users/ahonnecke/Movies/from_jj')
os.chdir(DIR)


def get_dirname(filename):
    els = filename.split('.')
    print(els)
    dirname = []
    for el in els:
        dirname.append(el)
        if el in ['2016', '2017', '2018']:
            return ' '.join(dirname)

    return ' '.join(dirname)


def main():
    for filename in os.listdir(DIR):
        if os.path.isdir(filename):
            try:
                os.rmdir(filename)
            except:
                pass

            continue

        dirname = get_dirname(filename)

        try:
            os.rmdir(dirname)
        except:
            pass

        try:
            print(f'Mkdir {dirname}')
            os.mkdir(dirname)
        except:
            pass

        # shutil.move(filename, f'{DIR}')
        # os.rename(filename, dirname)
        src = f'{DIR}/{filename}'
        dest = f'{DIR}/{dirname}/{filename}'
        print(f'{src} => {dest}')
        shutil.move(src, dest)


if __name__ == "__main__":
    main()
