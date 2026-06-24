{ pkgs, ... }:

{
  # --------------------------------------------------------------------------
  # Nerd Fonts
  # --------------------------------------------------------------------------
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # The primary terminal font used everywhere
    (nerdfonts.override {
      fonts = [
        "DroidSansMono"
        "DejaVuSansMono"
        "Inconsolata"       # closest to InconsolataLGC in nixpkgs
      ];
    })

    # CJK + emoji fonts (used in dunst, waybar, GTK)
    noto-fonts-cjk-sans
    noto-fonts-emoji

    # WQY ZenHei (CJK — bundled as a raw file in the original repo)
    wqy_zenhei
  ];

  # The original repo bundles font files directly; copy them too so any
  # app that expects the exact family name "InconsolataLGC Nerd Font Mono"
  # continues to work alongside the Nix-provided versions.
  home.file.".local/share/fonts/InconsolataLGC".source =
    ../../packages/fonts/.local/share/fonts/InconsolataLGC;
}
