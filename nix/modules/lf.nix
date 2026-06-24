{ pkgs, ... }:

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
      previewer = "~/.config/lf/previewer.sh";
      cleaner   = "~/.config/lf/clear_img.sh";
    };

    keybindings = {
      "<enter>" = "shell";
      x         = "delete";
    };

    commands.open = ''
      ${{
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

  # Carry the image preview / icons scripts verbatim
  home.file.".config/lf/previewer.sh".source =
    ../home/.config/lf/previewer.sh;
  home.file.".config/lf/draw_kitty.sh".source =
    ../home/.config/lf/draw_kitty.sh;
  home.file.".config/lf/draw_ueberzurg.sh".source =
    ../home/.config/lf/draw_ueberzurg.sh;
  home.file.".config/lf/clear_img.sh".source =
    ../home/.config/lf/clear_img.sh;
  home.file.".config/lf/icons".source =
    ../home/.config/lf/icons;
}
