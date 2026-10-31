{ config, pkgs, ... }:

{
  # --------------------------------------------------------------------------
  # lf file manager
  # --------------------------------------------------------------------------
  programs.lf = {
    enable = true;

    settings = {
      shell     = "sh";
      shellopts = "-eu";
      ifs       = "\\n";
      scrolloff = 10;
      icons     = true;
      drawbox   = true;
      previewer = "${config.xdg.configHome}/lf/previewer.sh";
      cleaner   = "${config.xdg.configHome}/lf/clear_img.sh";
    };

    keybindings = {
      "<enter>" = "shell";
      x         = "delete";
    };

    commands.open = ''
      ''${{
          test -L $f && f=$(readlink -f $f)
          case $(file --mime-type $f -b) in
              text/*) vim $fx;;
              image/*) swayimg $fx & ;;
              application/pdf) zathura $fx & ;;
              *) for f in $fx; do xdg-open $f > /dev/null 2> /dev/null & done;;
          esac
      }}
    '';
  };

  # --------------------------------------------------------------------------
  # required tools for content preview
  # --------------------------------------------------------------------------
  home.packages = with pkgs; [
    highlight
    swayimg
    ffmpegthumbnailer
    poppler-utils
    p7zip
    unzip
    imagemagick
    file
  ];

  # --------------------------------------------------------------------------
  # Zathura PDF viewer
  # --------------------------------------------------------------------------
  programs.zathura = {
    enable = true;
    options = {
      statusbar-bg = "#222222";
      statusbar-fg = "#ffffff";
      default-fg   = "#FFFFFF";
      default-bg   = "#222222";
    };
    mappings = {
      p = "print";
    };
  };

  # --------------------------------------------------------------------------
  # Preview scripts and icons
  # --------------------------------------------------------------------------
  xdg.configFile = {
    "lf/previewer.sh".source = ../home/.config/lf/previewer.sh;
    "lf/draw_kitty.sh".source = ../home/.config/lf/draw_kitty.sh;
    "lf/draw_ueberzurg.sh".source = ../home/.config/lf/draw_ueberzurg.sh;
    "lf/clear_img.sh".source = ../home/.config/lf/clear_img.sh;
    "lf/icons".source = ../home/.config/lf/icons;
  };

  # --------------------------------------------------------------------------
  # Highlight syntax highlighter custom filetypes
  # --------------------------------------------------------------------------
  home.file.".highlight/filetypes.conf".source =
    ../home/.highlight/filetypes.conf;

}
