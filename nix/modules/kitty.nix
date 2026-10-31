{ ... }:

let
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
  programs.kitty = {
    enable = true;

    font = {
      name = "InconsolataLGC Nerd Font Mono";
      size = 13;
    };

    settings = {
      # Eighties Dark colours
      color0  = eighties.black;
      color8  = eighties.black;
      color1  = eighties.red;
      color9  = eighties.red;
      color2  = eighties.green;
      color10 = eighties.green;
      color3  = eighties.yellow;
      color11 = eighties.yellow;
      color4  = eighties.blue;
      color12 = eighties.blue;
      color5  = eighties.magenta;
      color13 = eighties.magenta;
      color6  = eighties.cyan;
      color14 = eighties.cyan;
      color7  = eighties.white;
      color15 = eighties.white;
    };
  };
}
