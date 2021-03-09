#!/bin/bash

# https://www.reddit.com/r/emacs/comments/7c0ry9/insall_emacs_27_from_source_ubuntu_1710_notes/

sudo apt-get install python3-setuptools build-essential automake ripgrep
ln -s ~/src/fzf/ .fzf
#pull fzf

pip install --user pylint pytest flake8 mypy pre-commit isort black boto3 trepan3k

#pull emacs
cd ~/src/emacs/
./configure --with-mailutils --prefix="${HOME}/local" --with-json
make install

#pull a fresh version of prelude, reinstall stuff


sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo groupadd docker
sudo usermod -aG docker $USER
sudo chmod 666 /var/run/docker.sock
newgrp docker

sudo curl -L https://raw.githubusercontent.com/docker/compose/1.26.2/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose