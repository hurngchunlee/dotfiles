{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # ---------- content display/preview used by lf ----------
    highlight
    swayimg

    # ---------- Editor ----------
    vim

    # ---------- key management ----------
    #pass

    # ---------- Applications (keybindings / startup) ----------
    brave             # web browser (mod+b, dunst browser)
    #tessen            # password manager rofi frontend (mod+p)
    nextcloud-client  # cloud sync (sway startup)
    owncloud-client   # cloud sync (sway startup)
  ];
}
