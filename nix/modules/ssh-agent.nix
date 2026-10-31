{ pkgs, ... }:

{

  home.packages = with pkgs; [
    openssh
  ];

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
   
      ExecStart = "${pkgs.openssh}/bin/ssh-agent -D -t 3600 -a $SSH_AUTH_SOCK";
    };
   
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
