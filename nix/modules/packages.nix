{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # ---------- Wayland / compositor utilities ----------
    #sway
    #swaylock
    #swayidle
    #waybar
    #wofi
    #wl-clipboard      # wl-copy / wl-paste
    #wtype
    #grim              # screenshot backend (grimshot)
    #slurp             # region selector for screenshots
    #swappy            # screenshot annotator
    #xdg-desktop-portal-wlr
    #xdg-utils

    # ---------- Display / appearance ----------
    gammastep         # colour temperature (Wayland redshift)
    #dunst
    #libnotify         # notify-send
    swayimg           # Wayland image viewer (used by lf)

    # ---------- Terminal & shell ----------
    alacritty
    kitty
    starship
    direnv
    #zsh
    oh-my-zsh

    # ---------- Editor ----------
    vim

    # ---------- File managers ----------
    lf
    #ranger

    # ---------- Launchers ----------
    #rofi
    #rofi-pass

    # ---------- Audio / media ----------
    #pulseaudio        # pactl / pamixer for volume control
    #pavucontrol
    #playerctl

    # ---------- Networking ----------
    #networkmanagerapplet  # nm-applet

    # ---------- PDF & documents ----------
    #zathura

    # ---------- Productivity / CLI tools ----------
    #cheat
    highlight
    #fzf
    #jq
    #yq

    # ---------- Hardware utilities ----------
    #brightnessctl

    # ---------- Font rendering helpers ----------
    #fontconfig

    # ---------- Applications (keybindings / startup) ----------
    brave             # web browser (mod+b, dunst browser)
    evolution         # email client (mod+m, workspace 2)
    #eduvpn-client     # EduVPN GUI (mod+v)
    #tessen            # password manager rofi frontend (mod+p)
    nextcloud-client  # cloud sync (sway startup)
    owncloud-client   # cloud sync (sway startup)
    #dmenu             # fallback menu (dunst dmenu)

    # ---------- Miscellaneous ----------
    #gnome-keyring     # ssh-agent / secrets
    #xdotool
  ];
}
