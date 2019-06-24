#!/bin/bash

ssh -x -a -q ${2:+-W $1:$2} prod-web-bastion
