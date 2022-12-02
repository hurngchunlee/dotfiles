#!/bin/bash
#
# usage: exec_always ~/.local/bin/sway-reload-clamshell.sh /proc/acpi/button/lid/LID0/state

path_lid_state=$1

if grep -q closed $path_lid_state; then
    swaymsg output eDP-1 disable
else
    swaymsg output eDP-1 enable
fi
