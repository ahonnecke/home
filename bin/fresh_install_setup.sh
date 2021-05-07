#!/bin/bash

# https://www.reddit.com/r/emacs/comments/7c0ry9/insall_emacs_27_from_source_ubuntu_1710_notes/

cd ~/src/
git clone git@github.com:ahonnecke/home.git
git remote rename origin upstream
cd

cd ~/src/
git clone https://github.com/junegunn/fzf.git
git remote rename origin upstream
cd

sudo apt-get install python3-setuptools build-essential automake ripgrep

cd ~/src/
git clone --depth 1 https://github.com/junegunn/fzf.git
cd

ln -s ~/src/fzf/ .fzf
~/.fzf/install

pip install --user pylint pytest flake8 mypy pre-commit isort black trepan3k \
    faker argparse boto3

sudo apt install -y build-essential automake texinfo libjpeg-dev libncurses5-dev
sudo apt install -y libtiff5-dev libgif-dev libpng-dev libxpm-dev libgtk-3-dev libgnutls28-dev
sudo apt install -y libjansson4 libjansson-dev git
sudo apt install -y npm flameshot

#pull emacs
cd ~/src/
git clone git@github.com:emacs-mirror/emacs.git emacs
cd emacs

./autogen.sh
./configure --prefix="${HOME}/local" --with-json --with-mailutils
make install
cd

cd ~/src/
git clone git@github.com:ahonnecke/lain-emacs.git
cd ~/src/lain-emacs/
git submodule update --remote --merge

#pull a fresh version of prelude, reinstall stuff

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo groupadd docker
sudo usermod -aG docker $USER
sudo chmod 666 /var/run/docker.sock
newgrp docker

sudo curl -L https://raw.githubusercontent.com/docker/compose/1.29.2/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose

sudo ln -s /usr/bin/python3 /usr/bin/python

ln -s ~/src/home/.Xmodmap ~/

sudo curl -L https://raw.githubusercontent.com/docker/compose/1.26.2/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
