#!/usr/bin/env python3

import argparse
import json
import os

import boto3

DOCKERARN = 'arn:aws:iam::712182686879:role/dev-ashton-honnecke-role'
WEBARN = 'arn:aws:iam::974666675768:role/dev-ashton-honnecke-role'


def get_args():
    parser = argparse.ArgumentParser(description='Get task IP')

    parser.add_argument(
        'service',
        help='Service name, or partial service name'
    )

    parser.add_argument(
        '-c',
        '--cluster',
        help='The cluster to query'
    )

    parser.add_argument(
        '-t',
        '--task',
        help='The task to query'
    )

    return parser.parse_args()


def auth():
    # The calls to AWS STS AssumeRole must be signed with the access key ID
    # and secret access key of an existing IAM user or by using existing temporary
    # credentials such as those from antoher role. (You cannot call AssumeRole
    # with the access key for the root account.) The credentials can be in
    # environment variables or in a configuration file and will be discovered
    # automatically by the boto3.client() function. For more information, see the
    # Python SDK documentation:
    # http://boto3.readthedocs.io/en/latest/reference/services/sts.html#client

    # create an STS client object that represents a live connection to the
    # STS service
    sts_client = boto3.client('sts')

    # Call the assume_role method of the STSConnection object and pass the role
    # ARN and a role session name.
    assumedRoleObject = sts_client.assume_role(
        RoleArn=WEBARN,
        RoleSessionName="AssumeRoleSession1"
    )

    # From the response that contains the assumed role, get the temporary
    # credentials that can be used to make subsequent API calls
    credentials = assumedRoleObject['Credentials']

    # # Use the temporary credentials that AssumeRole returns to make a
    # # connection to Amazon S3
    # s3_resource = boto3.resource(
    #     's3',
    #     aws_access_key_id=credentials['AccessKeyId'],
    #     aws_secret_access_key=credentials['SecretAccessKey'],
    #     aws_session_token=credentials['SessionToken'],
    # )

    # # Use the Amazon S3 resource object that is now configured with the
    # # credentials to access your S3 buckets.
    # for bucket in s3_resource.buckets.all():
    #     print(bucket.name)

    return {
        'aws_access_key_id': credentials['AccessKeyId'],
        'aws_secret_access_key': credentials['SecretAccessKey'],
        'aws_session_token': credentials['SessionToken'],
    }


if __name__ == "__main__":
    args = get_args()
    creds = auth()

    ecs = boto3.client('ecs', **creds)

    serviceArns = {}
    for arn in ecs.list_clusters().get('clusterArns'):
        serviceArns[arn] = ecs.list_services(cluster=arn).get('serviceArns')

    for cluster, services in serviceArns.items():
        for service in services:
            if args.service in service:
                # print(f'{args.service} is in {service}')
                service_match = service
                cluster_match = cluster

    tasks = ecs.list_tasks(cluster=cluster_match).get('taskArns')

    response = ecs.describe_tasks(
        cluster=cluster_match,
        tasks=tasks
    )

    # print(f'{cluster_match}:::{service_match}')
    for task_detail in response.get('tasks'):
        if args.service in task_detail.get('group'):
            internal_ip = task_detail.get('containers')[0].get('networkInterfaces')[0].get('privateIpv4Address')

    print(internal_ip)
