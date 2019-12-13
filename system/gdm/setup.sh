#!/bin/bash
##############################################################
# This script illustrates commands to run with gdm user to
# customize the GDM login screen.
#
# Those commands need to be executed outside an X environment.
# e.g. in a console.
#
# Login as gdm user with the following command:
#
# $ machinectl shell gdm@ /bin/bash
#
##############################################################

# enable tap-to-click
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click 'true'

# scale font up
gsettings set org.gnome.desktop.interface text-scaling-factor '1.25'
