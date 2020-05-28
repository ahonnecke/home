#!/bin/bash

FULL_S3_PATH=$1
# awk -F / '{print $6}'
SUB_PATH=$(echo "$FULL_S3_PATH" | cut -f 3- -d /)

echo $SUB_PATH

URI="https://console.aws.amazon.com/s3/buckets/${SUB_PATH}?region=us-east-1"
firefox ${URI}
