{ config, pkgs, ... }:

{
  imports = [
    ./modules/packages.nix
    ./modules/fonts.nix
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/starship.nix
    ./modules/neovim.nix
    ./modules/alacritty.nix
    ./modules/kitty.nix
    ./modules/sway.nix
    ./modules/dunst.nix
    ./modules/lf.nix
    ./modules/misc.nix
  ];

  targets.genericLinux.enable = true;
  targets.genericLinux.nixGL.packages = null;
  targets.genericLinux.gpu.enable = true;

  # --------------------------------------------------------------------------
  # Home identity
  # --------------------------------------------------------------------------
  home.username = "dccntg";
  home.homeDirectory = "/home/dccntg";

  # --------------------------------------------------------------------------
  # Let home-manager manage itself
  # --------------------------------------------------------------------------
  programs.home-manager.enable = true;

  # --------------------------------------------------------------------------
  # State version — do not change after first activation
  # --------------------------------------------------------------------------
  home.stateVersion = "26.11";
}
