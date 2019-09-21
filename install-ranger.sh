#!/bin/bash

sudo pip install ranger-fm
sudo apt install rxvt w3m w3m-img

echo 'install ranger devicon plugin ...'
if [ -d ~/tmp/ranger_devicons ]; then
    rm -rf ~/tmp/ranger_devicons
fi
git clone https://github.com/alexanderjeurissen/ranger_devicons ~/tmp/ranger_devicons && \
cd ~/tmp/ranger_devicons && make install

echo 'install ranger with fuzzy finder ...'

sudo apt install mlocate findutils

if [ -d ~/tmp/fzf ]; then
    rm -rf ~/tmp/fzf
fi
git clone --depth 1 https://github.com/junegunn/fzf.git ~/tmp/fzf && \
cd ~/tmp/fzf && ./install && cp ./bin/fzf ~/.local/bin/fzf
