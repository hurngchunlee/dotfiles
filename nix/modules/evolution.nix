{pkgs, ...}:

{
  home.packages = with pkgs; [
    evolution         # email client (mod+m, workspace 2)
    evolution-ews     # evolution module for Exchange Web Services 
  ];
}
