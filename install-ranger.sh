#!/bin/bash

sudo pip install ranger-fm
sudo apt install rxvt w3m w3m-img

echo 'install ranger devicon plugin ...'
git clone https://github.com/alexanderjeurissen/ranger_devicons ~/tmp/ranger_devicons && \
cd ~/tmp/ranger_devicons && make install
