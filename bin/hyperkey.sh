#!/bin/bash

# touch /tmp/ran
DATE=$(date)
WHO=$(whoami)
echo "Executed on $DATE by $WHO" >> /tmp/hyperkey-meta.log

# date >> /tmp/hyperkey.log
#
# echo "by $WHO" >> /tmp/hyperkey.log

# env > /tmp/hyperkey_env.log

export DISPLAY=":1"
# export XAUTHORITY="/home/user/.Xauthority"

# su ahonnecke -c "xmodmap ~/.Xmodmap >/dev/null 2>&1 &"

xmodmap ~/.Xmodmap >/dev/null 2>&1 &

# https://askubuntu.com/questions/423627/how-to-make-hyper-and-super-keys-not-do-the-same-thing/794087#794087
# setxkbmap -option caps:hyper
# setxkbmap -option caps:none
