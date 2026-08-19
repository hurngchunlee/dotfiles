{ pkgs, config, ... }:

{
  # --------------------------------------------------------------------------
  # Sway window manager
  # --------------------------------------------------------------------------
  wayland.windowManager.sway = {
    enable = true;
    package = null;

    config = {
      modifier = "Mod1";       # Alt key

      # Default terminal / menu
      terminal = "alacritty";
      menu     = "wofi -i -I -G -S drun";

      # Font for titlebars
      fonts = {
        names = [ "DroidSansMono Nerd Font" ];
        size  = 13.0;
      };

      # Gaps
      gaps = {
        inner = 10;
        outer = 0;
      };

      # Window borders
      window.border = 3;

      # Window colours  (focused / unfocused / urgent)
      colors = {
        focused = {
          border      = "#0088CC";
          background  = "#0088CC";
          text        = "#ffffff";
          indicator   = "#ff661a";
          childBorder = "#0088cc";
        };
        unfocused = {
          border      = "#64727d80";
          background  = "#64727d80";
          text        = "#ffffff";
          indicator   = "#ff661a";
          childBorder = "#64727d80";
        };
        urgent = {
          border      = "#900000";
          background  = "#900000";
          text        = "#ffffff";
          indicator   = "#ff661a";
          childBorder = "#900000";
        };
      };

      # Touchpad
      input = {
        "type:touchpad" = {
          tap            = "enabled";
          natural_scroll = "enabled";
          dwt            = "enabled";
        };
      };

      # Cursor theme
      seat = {
        seat0 = {
          xcursor_theme = "Simp1e-breeze 32";
        };
      };

      # Wallpaper
      output = {
        "*" = {
          bg = "~/Pictures/wallpapers/landscape_art_tree_140205_1920x1080.jpg fill";
        };
      };

      # Status bar (waybar)
      bars = [{ command = "waybar"; }];

      # Keybindings
      keybindings =
        let mod = "Mod1"; win = "Mod4"; in {
          # Applications
          "${mod}+Return"  = "exec alacritty";
          "${mod}+b"       = "exec brave";
          "${mod}+m"       = "exec evolution";
          "${mod}+z"       = ''exec kitty zsh -c "source ~/.zshrc; lf"'';
          "${mod}+v"       = "exec eduvpn-gui";
          "${mod}+d"       = "exec wofi -i -I -G -S drun";
          "${mod}+p"       = "exec ~/.local/bin/tessen -d wofi -a copy";

          # Focus
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          # Move
          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";

          # Layout
          "${win}+h"   = "splith";
          "${win}+v"   = "splitv";
          "${mod}+s"   = "layout stacking";
          "${mod}+w"   = "layout tabbed";
          "${mod}+e"   = "layout toggle split";
          "${mod}+f"   = "fullscreen";
          "${mod}+space" = "floating toggle";

          # Kill / reload
          "${mod}+q"         = "kill";
          "${mod}+Shift+c"   = "reload";

          # Scratchpad
          "${win}+minus"  = "move scratchpad";
          "${mod}+minus"  = "scratchpad show";

          # Volume / brightness
          "XF86AudioRaiseVolume"  = "exec ~/.local/bin/pamixerctl inc";
          "XF86AudioLowerVolume"  = "exec ~/.local/bin/pamixerctl dec";
          "XF86AudioMute"         = "exec ~/.local/bin/pamixerctl toggle";
          "XF86AudioMicMute"      = "exec ~/.local/bin/micctl toggle";
          "XF86MonBrightnessUp"   = "exec ~/.local/bin/wbacklightctl inc";
          "XF86MonBrightnessDown" = "exec ~/.local/bin/wbacklightctl dec";

          # Display control
          "${win}+d" = "exec ~/.local/bin/wofi-outputctl";
          "${win}+p" = "exec ~/.local/bin/wofi-outputctl -p";

          # Clipboard paste
          "Ctrl+${mod}+v" = "exec wl-paste -p | wtype -";

          # Workspaces — switch
          "${mod}+1" = "workspace 1";
          "${mod}+2" = "workspace 2";
          "${mod}+3" = "workspace 3";
          "${mod}+4" = "workspace 4";
          "${mod}+5" = "workspace 5";
          "${mod}+6" = "workspace 6";
          "${mod}+7" = "workspace 7";
          "${mod}+8" = "workspace 8";
          "${mod}+9" = "workspace 9";
          "${mod}+x" = "workspace x";
          "${mod}+g" = "workspace g";

          # Workspaces — move
          "${mod}+Shift+1" = "move container to workspace 1";
          "${mod}+Shift+2" = "move container to workspace 2";
          "${mod}+Shift+3" = "move container to workspace 3";
          "${mod}+Shift+4" = "move container to workspace 4";
          "${mod}+Shift+5" = "move container to workspace 5";
          "${mod}+Shift+6" = "move container to workspace 6";
          "${mod}+Shift+7" = "move container to workspace 7";
          "${mod}+Shift+8" = "move container to workspace 8";
          "${mod}+Shift+9" = "move container to workspace 9";
          "${mod}+Shift+x" = "move container to workspace x";
          "${mod}+Shift+g" = "move container to workspace g";

          # Modes
          "${mod}+r"   = ''mode "resize"'';
          "${win}+e"   = ''mode "System (l) lock, (e) logout, (s) suspend, (h) hibernate, (r) reboot, (Shift+s) shutdown"'';
          "${win}+w"   = ''mode "Move workspace to display (t) top, (b) bottom, (l) left, (r) right"'';
          "${win}+c"   = ''mode "Move container to display (t) top, (b) bottom, (l) left, (r) right"'';
          "${mod}+c"   = ''mode "Take screenshot (o) output, (a) area, (w) window"'';
        };

      modes = {
        resize = {
          h      = "resize shrink width 10px";
          j      = "resize grow height 10px";
          k      = "resize shrink height 10px";
          l      = "resize grow width 10px";
          Return = "mode default";
          Escape = "mode default";
        };

        "System (l) lock, (e) logout, (s) suspend, (h) hibernate, (r) reboot, (Shift+s) shutdown" = {
          l          = "exec swaylock -f -i ${../home}/.screenlock -l -c 2B303B, mode default";
          e          = "exec swaymsg exit, mode default";
          s          = "exec systemctl suspend, mode default";
          h          = "exec systemctl hibernate, mode default";
          r          = "exec systemctl reboot, mode default";
          "Shift+s"  = "exec systemctl poweroff, mode default";
          Return     = "mode default";
          Escape     = "mode default";
        };

        "Move workspace to display (t) top, (b) bottom, (l) left, (r) right" = {
          t      = "move workspace to output up, mode default";
          b      = "move workspace to output down, mode default";
          l      = "move workspace to output left, mode default";
          r      = "move workspace to output right, mode default";
          Return = "mode default";
          Escape = "mode default";
        };

        "Move container to display (t) top, (b) bottom, (l) left, (r) right" = {
          t      = "move container to output up, mode default";
          b      = "move container to output down, mode default";
          l      = "move container to output left, mode default";
          r      = "move container to output right, mode default";
          Return = "mode default";
          Escape = "mode default";
        };

        "Take screenshot (o) output, (a) area, (w) window" = {
          o      = "exec ~/.local/bin/screenshot output, mode default";
          a      = "exec ~/.local/bin/screenshot area, mode default";
          w      = "exec ~/.local/bin/screenshot window, mode default";
          Return = "mode default";
          Escape = "mode default";
        };
      };

      # Window assignments
      assigns = {
        "2" = [{ app_id = "org.gnome.Evolution"; }];
        "4" = [{ class = "Code"; } { class = "code-oss"; }];
        "5" = [{ class = "Rambox"; } { class = "rambox"; } { class = "Signal"; } { class = "signal"; }];
        "6" = [{ class = "Remmina"; }];
        "7" = [{ class = "Vncviewer"; }];
        "8" = [{ app_id = "libreoffice-writer"; } { app_id = "libreoffice-calc"; } { app_id = "libreoffice-impress"; }];
        "9" = [{ class = "Joplin"; } { class = "Typora"; }];
      };

      floating.criteria = [
        { class = "Yad"; }
        { class = "Evolution-alarm-notify"; }
      ];

      # Laptop lid switch
      window.commands = [];

      # Startup applications
      startup = [
        # dbus environment
        {
          command = ''hash dbus-update-activation-environment 2>/dev/null && dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_SESSION_TYPE=wayland XDG_CURRENT_DESKTOP=sway'';
          always = true;
        }

	# NIX home manager environment variables
	{
	  command = ". ~/.nix-profile/etc/profile.d/hm-session-vars.sh";
	  always = true;
	}

        # GTK settings import
        { command = "~/.local/bin/import-gsettings"; always = true; }
        # Clipboard
        { command = "wl-paste -t text --watch wl-copy -p"; }
        # Screen lock / idle
        {
          command = ''swayidle -w timeout 10 'if pgrep -x swaylock; then swaymsg "output * power off"; fi' resume 'swaymsg "output * power on"' before-sleep 'playerctl -a pause; swaylock -f -i ${../home}/.screenlock -l -c 2B303B' '';
        }
        # Network manager applet
        { command = "nm-applet --indicator"; }
        # Laptop clamshell handler
        { command = "~/.local/bin/sway-reload-clamshell.sh /proc/acpi/button/lid/LID0/state"; always = true; }
        # Cloud sync clients
        { command = "sh -c 'sleep 3; owncloud'"; }
        { command = "sh -c 'sleep 3; nextcloud --background'"; }
      ];
    };

    # Lid switch bindings (not available in the home-manager DSL, pass as extraConfig)
    extraConfig = ''
      set $laptop eDP-1
      bindswitch --locked lid:on  output $laptop disable
      bindswitch --locked lid:off output $laptop enable
      bindswitch lid:on  output $laptop disable
      bindswitch lid:off output $laptop enable

      for_window [class=".*"]    border pixel
      for_window [app_id=".*"]   border pixel
    '';
  };

  # --------------------------------------------------------------------------
  # Waybar
  # --------------------------------------------------------------------------
  programs.waybar = {
    enable = true;

    settings = [{
      layer   = "top";
      height  = 37;
      spacing = 4;

      "modules-left"   = [ "sway/workspaces" "sway/mode" ];
      "modules-center" = [];
      "modules-right"  = [ "custom/vpn" "cpu" "battery" "pulseaudio" "clock" "tray" ];

      "sway/workspaces" = {
        disable-scroll = false;
        all-outputs    = false;
        format         = "{name} {icon}";
        format-icons   = {
          "1" = "";
          "2" = "📬";
          "3" = "🌍";
          "4" = "🛠️";
          "5" = "💬";
          "6" = "🔞";
          "7" = "🖥️";
          "8" = "📑";
          "9" = "📝";
          "x" = "🗃️";
          "g" = "🕹️";
        };
      };

      "custom/vpn" = {
        format       = "{} {icon}";
        format-icons = { active = ""; };
        exec         = "~/.local/bin/vpninfo";
        exec-if      = "test -d /proc/sys/net/ipv4/conf/tun0";
        return-type  = "json";
        interval     = 5;
      };

      cpu = {
        interval   = 10;
        format     = "{usage}% ";
        max-length = 10;
      };

      battery = {
        states       = { warning = 30; critical = 15; };
        format          = "{capacity}% {icon}";
        format-charging = "{capacity}% ";
        format-plugged  = "{capacity}% ﮣ";
        format-icons    = ["" "" "" "" ""];
      };

      pulseaudio = {
        format           = "{volume}% {icon}";
        format-bluetooth = "{volume}% {icon}[]";
        format-muted     = "";
        format-icons = {
          headphone  = "";
          hands-free = "";
          headset    = "";
          phone      = "";
          portable   = "";
          car        = "";
          default    = ["" ""];
        };
        scroll-step = 1;
        on-click    = "pavucontrol";
      };

      clock = {
        format-alt      = "{:%a, %d. %b  %H:%M}";
        tooltip-format  = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode         = "year";
          mode-mon-col = 3;
          weeks-pos    = "right";
          on-scroll    = 1;
          format = {
            months   = "<span color='#ffead3'><b>{}</b></span>";
            days     = "<span color='#ecc6d9'><b>{}</b></span>";
            weeks    = "<span color='#99ffdd'><b>W{}</b></span>";
            weekdays = "<span color='#ffcc66'><b>{}</b></span>";
            today    = "<span color='#ff6699'><b><u>{}</u></b></span>";
          };
        };
        actions = {
          on-click-right  = "mode";
          on-scroll-up    = "shift_up";
          on-scroll-down  = "shift_down";
        };
      };

      tray = {
        show-passive-items = true;
        icon-size          = 20;
        spacing            = 10;
      };
    }];

    style = builtins.readFile ../home/.config/waybar/style.css;
  };

  # --------------------------------------------------------------------------
  # Wofi launcher
  # --------------------------------------------------------------------------
  programs.wofi = {
    enable = true;
    settings = {
      allow_images = true;
      insensitive  = true;
      gtk_dark     = true;
    };
    style = builtins.readFile ../home/.config/wofi/style.css;
  };

  # --------------------------------------------------------------------------
  # Gammastep (Wayland redshift equivalent)
  # --------------------------------------------------------------------------
  services.gammastep = {
    enable          = true;
    provider        = "manual";
    latitude        = 52.2226;
    longitude       = 4.5322;
    temperature     = { day = 6000; night = 4200; };
    settings        = {
      general = {
          brightness-day = "1.0";
          brightness-night = "0.8";
      };
    };
    tray            = true;
  };

  # --------------------------------------------------------------------------
  # GTK theming
  # --------------------------------------------------------------------------
  gtk = {
    enable = true;
    theme.name       = "Adwaita";
    iconTheme.name   = "Adwaita";
    font.name        = "Noto Sans CJK TC 11";
    cursorTheme = {
      name = "Simp1e-breeze";
      size = 32;
    };
    gtk3.extraConfig = {
      gtk-toolbar-style              = "GTK_TOOLBAR_BOTH_HORIZ";
      gtk-toolbar-icon-size          = "GTK_ICON_SIZE_LARGE_TOOLBAR";
      gtk-button-images              = 0;
      gtk-menu-images                = 0;
      gtk-enable-event-sounds        = 1;
      gtk-enable-input-feedback-sounds = 1;
      gtk-enable-primary-paste       = 1;
      gtk-xft-antialias              = 1;
      gtk-xft-hinting                = 1;
      gtk-xft-hintstyle              = "hintfull";
      gtk-xft-rgba                   = "rgb";
      gtk-decoration-layout          = "appmenu:none";
      gtk-application-prefer-dark-theme = 0;
    };
  };

  # --------------------------------------------------------------------------
  # dconf setting to enale GNOME middle-key paste 
  # --------------------------------------------------------------------------
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-enable-primary-paste = true;      
      gtk-theme    = "Adwaita";
      icon-theme   = "Adwaita";
      color-scheme = "prefer-light";
    };
  };
}
