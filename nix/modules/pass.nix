{ pkgs, ... }:

{

  home.packages = with pkgs; [
    gnupg
    pass
    gopass
  ];

  # GPG agent
  services.gpg-agent = {
    enable = true;
    enableSshSupport = false;

    defaultCacheTtl = 3600;
    maxCacheTtl = 7200;
    pinentry.package = pkgs.pinentry-gnome3;
  };
}
