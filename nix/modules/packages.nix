{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # ---------- content display/preview used by lf ----------
    highlight
    swayimg
    ffmpegthumbnailer
    poppler-utils
    p7zip
    unzip
    imagemagick
    file
    zathura

    # ---------- Text editor ----------
    vim

    # ---------- utilities ----------
    jq
    bc
    wl-clipboard
    libnotify
    networkmanagerapplet

    # ---------- audio control ----------
    pamixer
    pavucontrol
    libcanberra-gtk3

    # ---------- screenshot and screencast tools ----------
    slurp
    grim
    swappy
    sway-contrib.grimshot

    # ---------- Applications --------
    gopass            # drop-in replacement of pass
    brave             # web browser (mod+b, dunst browser)
    tessen            # password manager rofi frontend (mod+p)
    nextcloud-client  # cloud sync (sway startup)
    owncloud-client   # cloud sync (sway startup)
  ];

  # fix schema 'org.gtk.Settings.FileChooser' is not installed error of NextCloud client 
  #home.sessionVariables.XDG_DATA_DIRS = "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"; 
}
