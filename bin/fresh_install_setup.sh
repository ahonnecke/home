#!/bin/bash

# https://www.reddit.com/r/emacs/comments/7c0ry9/insall_emacs_27_from_source_ubuntu_1710_notes/

sudo apt-get install python3-setuptools build-essential automake
pip install --user pylint pytest flake8 mypy pre-commit isort black
# get emacs
cd ~/src/emacs/
./configure --with-mailutils --prefix="${HOME}/local"
make install


sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
