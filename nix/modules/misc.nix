{ pkgs, ... }:

# ---------------------------------------------------------------------------
# Miscellaneous configs that don't have a first-class home-manager module.
# These are either placed verbatim via home.file or expressed as simple
# programs.* options.
# ---------------------------------------------------------------------------
{
  # --------------------------------------------------------------------------
  # Zathura PDF viewer
  # --------------------------------------------------------------------------
  programs.zathura = {
    enable = true;
    package = pkgs.emptyDirectory;
    options = {
      statusbar-bg = "#222222";
      statusbar-fg = "#ffffff";
      default-fg   = "#FFFFFF";
      default-bg   = "#222222";
    };
    mappings = {
      p = "print";
    };
  };

  # --------------------------------------------------------------------------
  # Nix package manager config (flakes + nix-command)
  # --------------------------------------------------------------------------
  home.file.".config/nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';

  # --------------------------------------------------------------------------
  # Cheat CLI cheatsheet tool
  # --------------------------------------------------------------------------
  home.file.".config/cheat/conf.yml".source =
    ../home/.config/cheat/conf.yml;
  home.file.".config/cheat/cheatsheets/personal/ls".source =
    ../home/.config/cheat/cheatsheets/personal/ls;

  # --------------------------------------------------------------------------
  # Highlight syntax highlighter custom filetypes
  # --------------------------------------------------------------------------
  home.file.".highlight/filetypes.conf".source =
    ../home/.highlight/filetypes.conf;

  # --------------------------------------------------------------------------
  # Systemd user environment (input method for Wayland)
  # --------------------------------------------------------------------------
  home.file.".config/environment.d/input.conf".text = ''
    GTK_IM_MODULE=ibus
    QT_IM_MODULE=ibus
    XMODIFIERS=@im=ibus
  '';

  # --------------------------------------------------------------------------
  # XDG desktop portal for wlr (screen sharing)
  # --------------------------------------------------------------------------
  home.file.".config/xdg-desktop-portal-wlr/config".source =
    ../home/.config/xdg-desktop-portal-wlr/config;

  # --------------------------------------------------------------------------
  # Rofi launcher
  # --------------------------------------------------------------------------
  home.file.".config/rofi".source = ../home/.config/rofi;

  # --------------------------------------------------------------------------
  # Ranger file manager
  # --------------------------------------------------------------------------
  home.file.".config/ranger".source = ../home/.config/ranger;

  # --------------------------------------------------------------------------
  # Conky system monitor
  # --------------------------------------------------------------------------
  home.file.".conkyrc".source = ../home/.conkyrc;


  # --------------------------------------------------------------------------
  # VS Code OSS settings
  # --------------------------------------------------------------------------
  home.file.".config/Code - OSS/User/settings.json".source =
    ../home/.config + "/Code - OSS/User/settings.json";

  # --------------------------------------------------------------------------
  # Local utility scripts (carried verbatim from sway packages)
  # --------------------------------------------------------------------------
  home.file.".local/bin" = {
    source    = ../home/.local/bin;
    recursive = true;
  };

  # --------------------------------------------------------------------------
  # Cursor theme (bundled in the repo)
  # --------------------------------------------------------------------------
  home.file.".icons/Simp1e-breeze".source = ../home/.icons/Simp1e-breeze;
  home.file.".icons/DMZ-White-Highlighted".source =
    ../home/.icons/DMZ-White-Highlighted;

  # --------------------------------------------------------------------------
  # Wallpapers / screenlock image
  # --------------------------------------------------------------------------
  home.file."Pictures/wallpapers".source  = ../home/Pictures/wallpapers;
  home.file.".screenlock".source          = ../home/.screenlock;
}
