{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # ---------- Wayland / compositor utilities ----------
    sway
    swaylock
    swayidle
    waybar
    wofi
    wl-clipboard      # wl-copy / wl-paste
    wtype
    grim              # screenshot backend (grimshot)
    slurp             # region selector for screenshots
    swappy            # screenshot annotator
    xdg-desktop-portal-wlr
    xdg-utils

    # ---------- Display / appearance ----------
    gammastep         # colour temperature (Wayland redshift)
    dunst
    libnotify         # notify-send
    feh               # image viewer (also used by lf)
    picom             # X11 compositor (i3 fallback)

    # ---------- Terminal & shell ----------
    alacritty
    kitty
    starship
    direnv
    zsh
    oh-my-zsh

    # ---------- Editor ----------
    neovim
    vim

    # ---------- File managers ----------
    lf
    ranger
    w3m               # ranger image preview on X11

    # ---------- Launchers ----------
    rofi
    rofi-pass

    # ---------- Audio / media ----------
    pulseaudio        # pactl / pamixer for volume control
    pavucontrol
    playerctl

    # ---------- Networking ----------
    networkmanagerapplet  # nm-applet

    # ---------- PDF & documents ----------
    zathura

    # ---------- Productivity / CLI tools ----------
    cheat
    highlight
    fzf
    jq
    yq

    # ---------- Hardware utilities ----------
    acpilight         # xbacklightctl / wbacklightctl backend
    brightnessctl

    # ---------- Font rendering helpers ----------
    fontconfig

    # ---------- Miscellaneous ----------
    gnome-keyring     # ssh-agent / secrets
    gcin              # Chinese input method
    xdotool
    wl-paste          # alias — already in wl-clipboard
  ];
}
