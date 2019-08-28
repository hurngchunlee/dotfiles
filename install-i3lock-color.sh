#!/bin/bash
#
# Note: this script is only tested on Ubuntu 18.04, x86_64 architecture.
#

## install dependencies
echo "installing required packages for building i3lock-color ..."
sudo apt install libev-dev \
                 libxcb-composite0 \
                 libxcb-composite0-dev \
                 libxcb-xinerama0 \
                 libxcb-randr0 \
                 libxcb-xrm0 \
                 libxcb-xinerama0-dev \
                 libxcb-xkb-dev \
                 libxcb-image0-dev \
                 libxcb-util-dev \
                 libxkbcommon-x11-dev \
                 libjpeg-turbo8-dev \
                 libpam0g-dev

echo "checking out i3lock-color source code ..."
mkdir -p ~/tmp
cd ~/tmp && \
git clone https://github.com/PandorasFox/i3lock-color.git && \
cd i3lock-color

echo "building i3lock-color ..."
autoreconf -i && ./configure && make

echo "installing i3lock-color to $HOME/.local/bin ..."
if [ -f x86_64-pc-linux-gnu/i3lock ]; then
    install -m 0755 $(pwd)/x86_64-pc-linux-gnu/i3lock $HOME/.local/bin/i3lock-color
    echo "i3lock-color installed as $(which i3lock-color)"
fi
