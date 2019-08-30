# Post configuration

## GTK-2/3 theme, icon-set and font

This setting is applied to GTK-based applications in menu bar, tabs and icons.

Use `lxappearance` utility to change the value accordingly.  After that, manually change the font name in `~/.gtkrc-2.0` and ` ~/.config/gtk-3.0/settings.ini`.

## Font of gnome-terminal

Make use of `dconf-editor` to change terminal profile propertie.

property path: `org.gnome.terminal.legacy.profiles.{profile-hash}.font`

with value `DejaVuSansMono Nerd Font Mono 12`

## Gnome Tweak

Another way is to use the `gnome-tweak` tool to configure font, theme etc.
