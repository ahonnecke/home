#!/bin/bash

xmodmap ~/.Xmodmap >/dev/null 2>&1 &

# https://askubuntu.com/questions/423627/how-to-make-hyper-and-super-keys-not-do-the-same-thing/794087#794087
# setxkbmap -option caps:hyper
# setxkbmap -option caps:none
