{ ... }:

{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        monitor    = 0;
        follow     = "mouse";

        width      = 300;
        height     = 100;
        origin     = "top-right";
        offset     = "3x3";

        indicate_hidden   = "yes";
        shrink            = "no";
        transparency      = 10;
        corner_radius     = 8;

        separator_height     = 1;
        padding              = 8;
        horizontal_padding   = 8;
        frame_width          = 1;
        frame_color          = "#666666";
        separator_color      = "frame";

        sort           = "yes";
        idle_threshold = 120;

        font        = "Noto Sans CJK TC Regular 13";
        line_height = 0;
        markup      = "full";
        format      = "<b>%s</b>\\n%b";
        alignment   = "left";

        show_age_threshold  = 60;
        word_wrap           = "yes";
        ellipsize           = "middle";
        ignore_newline      = "no";
        stack_duplicates    = true;
        hide_duplicate_count = false;
        show_indicators     = "yes";

        icon_position  = "left";
        max_icon_size  = 32;
        icon_path      = "/usr/share/icons/hicolor/32x32/apps:/usr/share/icons/hicolor/scalable/apps/";

        sticky_history  = "yes";
        history_length  = 20;

        dmenu   = "/usr/bin/dmenu -p dunst:";
        browser = "/usr/bin/brave";

        always_run_script = true;
        title = "Dunst";
        class = "Dunst";

        layer          = "top";
        force_xwayland = false;
        force_xinerama = false;
      };

      experimental = {
        per_monitor_dpi = false;
      };

      urgency_low = {
        background  = "#2b303bcc";
        foreground  = "#ffffff";
        frame_color = "#64727d";
        timeout     = 10;
      };

      urgency_normal = {
        background  = "#0172aacc";
        foreground  = "#ffffff";
        frame_color = "#0088CC";
        timeout     = 10;
      };

      urgency_critical = {
        background  = "#600000cc";
        foreground  = "#ffffff";
        frame_color = "#900000";
        timeout     = 0;
      };

      evolution = {
        appname = "evolution-mail-notification";
        summary = "*";
        script  = "~/.local/bin/i3ws-set-urgent";
      };
    };
  };
}
