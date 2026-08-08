{ config, pkgs, username, homeDirectory, ... }:

{
  imports = [
    ./modules/packages.nix
    ./modules/fonts.nix
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/neovim.nix
    ./modules/alacritty.nix
    ./modules/kitty.nix
    ./modules/sway.nix
    ./modules/dunst.nix
    ./modules/lf.nix
    ./modules/evolution.nix
    ./modules/misc.nix
    ./modules/services.nix
  ];

  targets.genericLinux.enable = true;
  targets.genericLinux.nixGL.packages = null;
  targets.genericLinux.gpu.enable = true;

  # --------------------------------------------------------------------------
  # Home identity
  # --------------------------------------------------------------------------
  home.username = username;
  home.homeDirectory = homeDirectory;

  # --------------------------------------------------------------------------
  # make packages managed by NIX available to Sway
  # --------------------------------------------------------------------------
  systemd.user.sessionVariables = {
    PATH = "$HOME/.nix-profile/bin:$HOME/.local/bin:/nix/var/nix/profiles/default/bin:/usr/local/sbin:/usr/local/bin:/usr/bin";
  };

  # --------------------------------------------------------------------------
  # Let home-manager manage itself
  # --------------------------------------------------------------------------
  #programs.home-manager.enable = true;

  # --------------------------------------------------------------------------
  # State version — do not change after first activation
  # --------------------------------------------------------------------------
  home.stateVersion = "26.11";
}
