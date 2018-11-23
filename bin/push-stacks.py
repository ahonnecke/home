#!/usr/bin/env python3

import argparse
import os
import subprocess


def get_args():
    parser = argparse.ArgumentParser(description='Deploy Digital Assets Stacks')

    parser.add_argument(
        '-e',
        '--environment',
        required=True,
        help='The environment to deploy to'
    )

    parser.add_argument(
        '-d',
        '--dryrun',
        action='store_true',
        default=False,
        help='Do not make any changes, just try it out'
    )

    # default_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    default_root = '/Users/ahonnecke/Code/repos'
    parser.add_argument(
        '-o',
        '--root',
        default=default_root,
        help=f'The directory that contains infra and infra-deploy'
        + f'(Default is determined by the location of this repository {default_root})'
    )

    args = parser.parse_args()

    infra_deploy_path = f'{args.root}/infra-deploy/'
    infra_path = f'{args.root}/infra/'

    if not os.path.isdir(infra_path):
        raise Exception(f'{infra_path} is not a directory')

    print(f'Infra repository is at {infra_path}')

    if not os.path.isdir(infra_deploy_path):
        raise Exception(f'{infra_deploy_path} is not a directory')

    print(f'Infra-deploy repository is at {infra_deploy_path}')

    prepare_stacks_path = f'{infra_deploy_path}scripts/prepare_stacks.py'

    if not os.path.isfile(prepare_stacks_path):
        raise Exception(f'{prepare_stacks_path} is not a file')

    print(f'prepare stacks is at {prepare_stacks_path}')

    return (args, infra_deploy_path, prepare_stacks_path)


def prepare_stacks(prepare_stacks_path, env):
    if not os.path.isfile(prepare_stacks_path):
        raise Exception(f'Unable to find prepare_stacks file at {prepare_stacks_path}')

    mydirname = os.path.dirname(prepare_stacks_path)
    print(f'CDing to {mydirname}')
    # Prepare stacks freaks out if you're not in the scripts directory
    os.chdir(mydirname)

    my_file = os.path.basename(prepare_stacks_path)
    print(f'executing relative file {my_file}')

    result = subprocess.run([my_file, env], stdout=subprocess.PIPE)
    print(result.stdout.decode('utf-8'))


def launch_stacks(infra_deploy_path, env):
    os.chdir(infra_deploy_path)
    result = subprocess.run(['sceptre', 'launch-env', env], stdout=subprocess.PIPE)
    print(result.stdout.decode('utf-8'))


def pipenv_check():
    try:
        if os.environ['PIPENV_ACTIVE']:
            print("Using pipenv and " + os.environ['PIP_PYTHON_PATH'])
            return True
    except KeyError:
        return False


if __name__ == "__main__":
    (args, infra_deploy_path, prepare_stacks_path) = get_args()

    if not pipenv_check():
        print('This deploy script must be started with "pipenv shell", let us go there now')
        os.chdir(infra_deploy_path)
        subprocess.run(['pipenv', 'shell'])
        exit(1)

    print(f'\n############# Preparing stacks for {args.environment} #################')
    prepare_stacks(prepare_stacks_path, args.environment)

    print(f'\n############# Launching stacks for {args.environment} #################')
    if args.dryrun:
        print('* but not actually just dry running')
    else:
        # notify(f'Beginning release of build {build} to {args.environment}')
        launch_stacks(infra_deploy_path, args.environment)
