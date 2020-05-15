#!/bin/bash
# I got sick and tired of AWS's shitty role switcher, this scrapes your config
# and sends you to the sole switching page, TODO: make it submit after you go there
# (or go directly to the action page)

ROLE_NAME=$1

ARN=$(grep -v region ~/.aws/config | grep -v source | grep -A1 "${ROLE_NAME}" | tail -n1)

ACCOUNT=$(echo "$ARN" | awk -F : '{print $5}')
MYROLENAME=$(echo "$ARN" | awk -F : '{print $6}' | awk -F / '{print $2}')

PARAMS="roleName=${MYROLENAME}&account=${ACCOUNT}&displayName=${ROLE_NAME}"
firefox https://signin.aws.amazon.com/switchrole?"${PARAMS}"
