#!/usr/bin/env python3

import boto3
import time
import argparse
import sys

ECR_ACCOUNT = "712182686879"
ROLE_ARN = ""

if not ROLE_ARN:
    print('A Role ARN is requried')
    exit(1)


def query_yes_no(question, default="yes"):
    """Ask a yes/no question via input() and return their answer.

    "question" is a string that is presented to the user.
    "default" is the presumed answer if the user just hits <Enter>.
        It must be "yes" (the default), "no" or None (meaning
        an answer is required of the user).

    The "answer" return value is True for "yes" or False for "no".
    """
    valid = {"yes": True, "y": True, "ye": True,
             "no": False, "n": False}
    if default is None:
        prompt = " [y/n] "
    elif default == "yes":
        prompt = " [Y/n] "
    elif default == "no":
        prompt = " [y/N] "
    else:
        raise ValueError("invalid default answer: '%s'" % default)

    while True:
        sys.stdout.write(question + prompt)
        choice = input().lower()
        if default is not None and choice == '':
            return valid[default]
        elif choice in valid:
            return valid[choice]
        else:
            sys.stdout.write("Please respond with 'yes' or 'no' "
                             "(or 'y' or 'n').\n")


def role_arn_to_session(**args):
    """
    Usage :
        session = role_arn_to_session(
            RoleArn='arn:aws:iam::012345678901:role/example-role',
            RoleSessionName='ExampleSessionName')
        client = session.client('sqs')
    """
    client = boto3.client('sts')

    response = client.assume_role(**args)

    return boto3.Session(
        aws_access_key_id=response['Credentials']['AccessKeyId'],
        aws_secret_access_key=response['Credentials']['SecretAccessKey'],
        aws_session_token=response['Credentials']['SessionToken'])


def restart_all(container_name, time_to_sleep: int = 180):
    session = role_arn_to_session(
        RoleArn=ROLE_ARN,
        RoleSessionName='ExampleSessionName')

    ecsclient = session.client("ecs")
    taskArns = ecsclient.list_tasks(cluster=CLUSTER_ARN)["taskArns"]
    response = ecsclient.describe_tasks(cluster=CLUSTER_ARN, tasks=taskArns)

    tasks = response["tasks"]
    stoped = 0
    for task in tasks:
        startedAt = task.get("startedAt", None)
        if not startedAt:
            continue

        if task["containers"][0]["name"] == container_name:
            taskArn = task["taskArn"]
            if query_yes_no(
                    f'Do you want to stop {container_name} ({taskArn})',
                    "no"
            ):
                print("Stopping...")
                ecsclient.stop_task(cluster=CLUSTER_ARN, task=taskArn)
                time.sleep(time_to_sleep)
                stoped = stoped + 1

    if stoped == 0:
        print(
            f'Unable to find any containers named {container_name}...'
            ' Are you sure that you entered the correct environment (-e)?'
        )
    else:
        print(f'stoped {stoped} containers')


parser = argparse.ArgumentParser(description='Stop a container by name')
parser.add_argument('container_name', help='The name of the containers you want to stop')
parser.add_argument(
    '-e',
    '--environment',
    default="dev",
    help='The environment to look for the container in'
)
args = parser.parse_args()

CLUSTER_ARN = f'arn:aws:ecs:us-east-1:974666675768:cluster/{args.environment}-web'

restart_all(args.container_name, 0)
