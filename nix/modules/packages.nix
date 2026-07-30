{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # ---------- content display/preview used by lf ----------
    highlight
    swayimg

    # ---------- Editor ----------
    vim

    # ---------- Applications (keybindings / startup) ----------
    brave             # web browser (mod+b, dunst browser)
    evolution         # email client (mod+m, workspace 2)
    #tessen            # password manager rofi frontend (mod+p)
    nextcloud-client  # cloud sync (sway startup)
    owncloud-client   # cloud sync (sway startup)
  ];
}
