{ pkgs, ... }:

# ---------------------------------------------------------------------------
# Miscellaneous configs that don't have a first-class home-manager module.
# These are either placed verbatim via home.file or expressed as simple
# programs.* options.
# ---------------------------------------------------------------------------
{
  xdg.configFile = {
    "nix/nix.conf".text = ''
      experimental-features = nix-command flakes
    '';
    "Code - OSS/User/settings.json".source = ../home/config + "/Code - OSS/User/settings.json";
  };
}
