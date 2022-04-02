#!/bin/bash
f=$1
w=$2
h=$3
x=$4
y=$5

[ -n "$(which kitty 2>/dev/null)" ] &&
    kitty +icat --silent --transfer-mode file --place "${w}x${h}@${x}x${y}" "$f"
