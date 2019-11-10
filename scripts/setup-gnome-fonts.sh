#!/bin/bash

####################################################################
# This script sets up the preferred fonts for GNOME applications.
# It is equivalent to changing "Fonts" in gnome-tweaks application.
####################################################################

gsettings set org.gnome.desktop.interface font-name 'Noto Sans CJK TC 10'

gsettings set org.gnome.desktop.interface document-font-name 'Noto Serif CJK TC Medium 11'

gsettings set org.gnome.desktop.interface monospace-font-name 'DroidSansMono Nerd Font Mono 11'

# font scaling factor, better set it to be the same as the GDK_DPI_SCALE
gsettings set org.gnome.desktop.interface text-scaling-factor 1.0

gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Noto Sans CJK TC Medium 10'
