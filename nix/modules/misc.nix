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
    ../../packages/cheat/.config/cheat/conf.yml;
  home.file.".config/cheat/cheatsheets/personal/ls".source =
    ../../packages/cheat/.config/cheat/cheatsheets/personal/ls;

  # --------------------------------------------------------------------------
  # Highlight syntax highlighter custom filetypes
  # --------------------------------------------------------------------------
  home.file.".highlight/filetypes.conf".source =
    ../../packages/highlight/.highlight/filetypes.conf;

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
    ../../packages/sway/.config/xdg-desktop-portal-wlr/config;

  # --------------------------------------------------------------------------
  # Rofi launcher
  # --------------------------------------------------------------------------
  home.file.".config/rofi".source = ../../packages/rofi/.config/rofi;

  # --------------------------------------------------------------------------
  # Ranger file manager
  # --------------------------------------------------------------------------
  home.file.".config/ranger".source = ../../packages/ranger/.config/ranger;

  # --------------------------------------------------------------------------
  # Conky system monitor
  # --------------------------------------------------------------------------
  home.file.".conkyrc".source = ../../packages/conky/.conkyrc;

  # --------------------------------------------------------------------------
  # X11 resources / profile (for i3/Xorg fallback sessions)
  # --------------------------------------------------------------------------
  home.file.".Xresources".source = ../../packages/xorg/.Xresources;
  home.file.".xprofile".source   = ../../packages/xorg/.xprofile;
  home.file.".Xdefaults".source  = ../../packages/sway/.Xdefaults;

  # --------------------------------------------------------------------------
  # i3 window manager (X11 fallback)
  # --------------------------------------------------------------------------
  home.file.".config/i3".source        = ../../packages/i3/.config/i3;
  home.file.".config/i3blocks".source  = ../../packages/i3blocks/.config/i3blocks;
  home.file.".config/sxhkd".source     = ../../packages/sxhkd/.config/sxhkd;

  # --------------------------------------------------------------------------
  # Picom compositor (X11)
  # --------------------------------------------------------------------------
  home.file.".config/picom.conf".source = ../../packages/picom/.config/picom.conf;

  # --------------------------------------------------------------------------
  # Redshift (X11 colour temperature)
  # --------------------------------------------------------------------------
  home.file.".config/redshift/redshift.conf".source =
    ../../packages/redshift/.config/redshift/redshift.conf;

  # --------------------------------------------------------------------------
  # VS Code OSS settings
  # --------------------------------------------------------------------------
  home.file.".config/Code - OSS/User/settings.json".source =
    ../../packages/vscode/.config/Code\ -\ OSS/User/settings.json;

  # --------------------------------------------------------------------------
  # Local utility scripts (carried verbatim from sway / i3 packages)
  # --------------------------------------------------------------------------
  home.file.".local/bin" = {
    source    = ../../packages/sway/.local/bin;
    recursive = true;
  };

  # i3 scripts (merge into .local/bin; sway scripts take precedence)
  home.file.".local/bin/i3exit".source          = ../../packages/i3/.local/bin/i3exit;
  home.file.".local/bin/i3help".source          = ../../packages/i3/.local/bin/i3help;
  home.file.".local/bin/i3ws-set-urgent".source = ../../packages/i3/.local/bin/i3ws-set-urgent;
  home.file.".local/bin/pamixerctl".source      = ../../packages/i3/.local/bin/pamixerctl;
  home.file.".local/bin/amixerctl".source       = ../../packages/i3/.local/bin/amixerctl;
  home.file.".local/bin/micctl".source          = ../../packages/i3/.local/bin/micctl;
  home.file.".local/bin/xbacklightctl".source   = ../../packages/i3/.local/bin/xbacklightctl;
  home.file.".local/bin/xrandrctl".source       = ../../packages/i3/.local/bin/xrandrctl;
  home.file.".local/bin/xscreenshot".source     = ../../packages/i3/.local/bin/xscreenshot;
  home.file.".local/bin/progressbar".source     = ../../packages/i3/.local/bin/progressbar;
  home.file.".local/bin/rofi-eduvpn".source     = ../../packages/i3/.local/bin/rofi-eduvpn;
  home.file.".local/bin/rofi-wifi-menu".source  = ../../packages/i3/.local/bin/rofi-wifi-menu;

  # rofi-bookmarker scripts
  home.file.".local/bin/rofi-bookmarker".source =
    ../../packages/rofi-bookmarker/.local/bin/rofi-bookmarker;

  # --------------------------------------------------------------------------
  # Cursor theme (bundled in the repo)
  # --------------------------------------------------------------------------
  home.file.".icons/Simp1e-breeze".source = ../../packages/icons/.icons/Simp1e-breeze;
  home.file.".icons/DMZ-White-Highlighted".source =
    ../../packages/icons/.icons/DMZ-White-Highlighted;

  # --------------------------------------------------------------------------
  # Wallpapers / screenlock image
  # --------------------------------------------------------------------------
  home.file."Pictures/wallpapers".source  = ../../packages/wallpapers/Pictures/wallpapers;
  home.file.".screenlock".source          = ../../packages/wallpapers/.screenlock;
}
