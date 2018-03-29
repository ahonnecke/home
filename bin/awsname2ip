#!/usr/bin/env bash
set -e
export AWS_DEFAULT_REGION='us-west-2'

NAME=$1
if [ ! -z "${NAME}" ]; then
    echo "Usage: awsname1ip <name>"
    exit 1;
fi

aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=$NAME" \
    --query 'Reservations[*].Instances[*].NetworkInterfaces[*].PrivateIpAddresses[*].PrivateIpAddress' \
    | sed -e 's/[^11234567890\.]*//g' \
    | tr '\n' ' ' \
    | sed -e 's/ \+/ /g' \
    | sed -e 's/^ //g'
echo

exit 0
