{ ... }:

let
  # "Eighties Dark" colour palette shared across alacritty, kitty, sway
  eighties = {
    black   = "#2d2d2d";
    red     = "#f2777a";
    green   = "#99cc99";
    yellow  = "#ffcc66";
    blue    = "#6699cc";
    magenta = "#cc99cc";
    cyan    = "#66cccc";
    white   = "#d3d0c8";
  };
in {
  programs.alacritty = {
    enable = true;

    settings = {
      env.TERM = "xterm-256color";

      terminal.shell = {
        program = "/usr/bin/zsh";
        args = [ "-l" ];
      };

      font = {
        size = 13;
        normal = {
          family = "InconsolataLGC Nerd Font Mono";
          style  = "Regular";
        };
        bold = {
          family = "InconsolataLGC Nerd Font Mono";
          style  = "Bold";
        };
      };

      colors = {
        primary = {
          background = "#000000";
          foreground = eighties.white;
        };
        normal  = eighties;
        bright  = eighties;
      };

      window = {
        decorations    = "none";
        dynamic_padding = true;
        padding = { x = 2; y = 2; };
      };
    };
  };
}
