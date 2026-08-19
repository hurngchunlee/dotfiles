{ pkgs, ... }:

{
  # --------------------------------------------------------------------------
  # Nerd Fonts
  # --------------------------------------------------------------------------
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # The primary terminal font used everywhere
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.inconsolata
    # CJK + emoji fonts (used in dunst, waybar, GTK)
    noto-fonts-cjk-sans
    noto-fonts-color-emoji

    # WQY ZenHei (CJK — bundled as a raw file in the original repo)
    wqy_zenhei
  ];

  # The original repo bundles font files directly; copy them too so any
  # app that expects the exact family name "InconsolataLGC Nerd Font Mono"
  # continues to work alongside the Nix-provided versions.
  home.file.".local/share/fonts/opentype".source =
    ../home/.local/share/fonts/opentype;
  home.file.".local/share/fonts/truetype".source =
    ../home/.local/share/fonts/truetype;
}
