{ config, pkgs, username, homeDirectory, ... }:

{
  imports = [
    ./modules/sway.nix
  ];

  #targets.genericLinux.enable = true;
  #targets.genericLinux.nixGL.packages = null;
  #targets.genericLinux.gpu.enable = true;

  # --------------------------------------------------------------------------
  # Home identity
  # --------------------------------------------------------------------------
  home.username = username;
  home.homeDirectory = homeDirectory;

  # --------------------------------------------------------------------------
  # Let home-manager manage itself
  # --------------------------------------------------------------------------
  programs.home-manager.enable = true;

  # --------------------------------------------------------------------------
  # State version — do not change after first activation
  # --------------------------------------------------------------------------
  home.stateVersion = "26.05";
    
}
