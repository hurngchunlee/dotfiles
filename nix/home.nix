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

  # --------------------------------------------------------------------------
  # Home identity
  # --------------------------------------------------------------------------
  home.username = "hclee";
  home.homeDirectory = "/home/hclee";

  # --------------------------------------------------------------------------
  # Let home-manager manage itself
  # --------------------------------------------------------------------------
  programs.home-manager.enable = true;

  # --------------------------------------------------------------------------
  # State version — do not change after first activation
  # --------------------------------------------------------------------------
  home.stateVersion = "24.11";
}
