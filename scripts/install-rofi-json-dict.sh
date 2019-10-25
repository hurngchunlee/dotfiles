#!/bin/bash

sudo apt install libjson-c-dev
sudo apt install rofi-dev

mkdir -p ~/tmp

git clone https://github.com/marvinkreis/rofi-json-dict.git ~/tmp/rofi-json-dict && cd ~/tmp/rofi-json-dict && ./configure && make && make install
