{ pkgs, ... }:

{
  # SSH agent
  systemd.user.services.ssh-agent = {
    Unit = {
      Description = "SSH key agent";
    };
   
    Service = {
      Type = "simple";
   
      Environment = [
        "SSH_AUTH_SOCK=%t/ssh-agent.socket"
      ];
   
      ExecStart = "/usr/bin/ssh-agent -D -t 3600 -a $SSH_AUTH_SOCK";
    };
   
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # GPG agent
  services.gpg-agent = {
    enable = true;
    package = pkgs.emptyDirectory;

    enableSshSupport = false;

    defaultCacheTtl = 3600;
    maxCacheTtl = 7200;
    pinentry.package = pkgs.pinentry-gnome3;
  };
}
