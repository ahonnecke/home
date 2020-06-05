#!/bin/bash


ROLENAME="prod-ashton-honnecke-role"
ROLENAME="dev-ashton-honnecke-role"

ACCOUNT="276497689543"

firefox https://signin.aws.amazon.com/switchrole?roleName=$ROLENAME&account=$ACCOUNT
