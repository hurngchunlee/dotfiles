#!/bin/bash -x
f=$1
w=$2
h=$3
x=$4
y=$5

## Notice the kitty's breaking change: https://github.com/gokcehan/lf/issues/1099
[ -n "$(which kitty 2>/dev/null)" ] &&
    kitty +kitten icat --silent --transfer-mode file --stdin no --place "${w}x${h}@${x}x${y}" "$f" < /dev/null > /dev/tty
