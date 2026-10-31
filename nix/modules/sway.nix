{ pkgs, config, ... }:

{

  imports = [
    ./alacritty.nix
    ./dunst.nix
    ./fonts.nix
    ./gammastep.nix
    ./git.nix
    ./kitty.nix
    ./lf.nix
    ./misc.nix
    ./neovim.nix
    ./pass.nix
    ./ssh-agent.nix
    ./wofi.nix
    ./zsh.nix
  ];

  # --------------------------------------------------------------------------
  # packages required
  # --------------------------------------------------------------------------
  home.packages = with pkgs; [
    # ---------- utilities ----------
    jq
    bc
    wl-clipboard
    libnotify
    networkmanagerapplet

    # ---------- audio control ----------
    pamixer
    pavucontrol
    libcanberra-gtk3

    # ---------- screenshot and screencast tools ----------
    slurp
    grim
    swappy
    sway-contrib.grimshot

    # ---------- Applications --------
    brave             # web browser (mod+b, dunst browser)
    tessen            # password manager rofi frontend (mod+p)
    nextcloud-client  # cloud sync (sway startup)
    owncloud-client   # cloud sync (sway startup)
  ];

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
          "${mod}+z"       = ''exec kitty ${pkgs.zsh}/bin/zsh -c "source ~/.zshrc; lf"'';
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

      include /etc/sway/config.d/*
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

      "gtk-layer-shell" = false;

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

    style = ''
      * {
          /* the following two causes the checkbox not being shown*/
          /* border: none; */
          /* min-height: 0; */
          border-radius: 0;
          font-family: DroidSansMono Nerd Font;
          font-size: 18px;
      }
      window#waybar {
          background: rgba(43, 48, 59, 0.9);
          border-bottom: 3px solid rgb(100, 114, 125);
          color: white;
      }
      tooltip {
        background: rgba(43, 48, 59, 0.8);
        border: 1px solid rgba(100, 114, 125, 0.8);
      }
      tooltip label {
        color: white;
      }
      #workspaces button {
          padding: 5px 10px;
          background: transparent;
          box-shadow: none;
          text-shadow: none;
          color: white;
          border: none;
          border-bottom: 3px solid transparent;
      }
      #workspaces button.focused {
          background: #0172aa;
          border-bottom: 3px solid #0088CC;
      }
      #workspaces button:hover {
          border-bottom: 3px solid #F9AF4F;
      }
      #workspaces button.urgent {
          background: #600000;
          border-bottom: 3px solid #900000;
      }
      #mode {
          padding: 0 10px;
          background: #8600b3;
          border: 3px solid #ad53cc;
          color: white;
      }
      #custom-vpn, #clock, #battery, #tray, #cpu, #pulseaudio {
          padding: 0 10px;
          background: transparent;
          border-bottom: 3px solid rgb(100, 114, 125);
          color: white;
      }
      #custom-vpn {
          color: #91B362;
      }
      #tray menu {
          /* font setting doesn't seem to work within the context menu style */
          font-family: Noto Sans CJK TC;
          background: rgba(43, 48, 59, 0.8);
          border: 1px solid rgba(100, 114, 125, 0.8);
          color: white;
      }
      #battery.charging {
          color: #91B362;
      }
      #battery.warning {
          color: #F9AF4F;
      }
      @keyframes blink {
          to {
              color: #900000;
          }
      }
      #battery.critical:not(.charging) {
          color: #600000;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }
    '';
  };

  # --------------------------------------------------------------------------
  # xdg-portal configuration and preferences
  # --------------------------------------------------------------------------
  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
    ];

    config = {
      sway = {
        default = "wlr";
        "org.freedesktop.impl.portal.ScreenCast" = "wlr";
        "org.freedesktop.impl.portal.Screenshot" = "wlr";
      };
    };
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

    gtk3.extraCss = ''
      /* Remove rounded corners */
      .titlebar,
      .titlebar .background,
      decoration,
      window,
      window.background {
          border-radius: 0;
          box-shadow: none;
      }

      /* Remove csd shadows */
      decoration, decoration:backdrop {
          box-shadow: none;
      }
    '';
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

  xdg.configFile = {
    # --------------------------------------------------------------------------
    # Systemd user environment (input method for Wayland)
    # --------------------------------------------------------------------------
    "environment.d/input.conf".text = ''
      GTK_IM_MODULE=ibus
      QT_IM_MODULE=ibus
      XMODIFIERS=@im=ibus
    '';

    # --------------------------------------------------------------------------
    # XDG desktop portal for wlr (screen sharing)
    # --------------------------------------------------------------------------
    "xdg-desktop-portal-wlr/config".text = ''
      [screencast]
      chooser_type=dmenu
      chooser_cmd=swaymsg -t get_outputs | jq -r '.[] | "Monitor: " + .name' | wofi -dmenu -p "select display port"
      output_name=eDP-1
      max_fps=30    
    '';
  };

  # --------------------------------------------------------------------------
  # Local utility scripts (carried verbatim from sway packages)
  # --------------------------------------------------------------------------
  home.file.".local/bin" = {
    source    = ../home/.local/bin;
    recursive = true;
  };

  # --------------------------------------------------------------------------
  # Cursor theme (bundled in the repo)
  # --------------------------------------------------------------------------
  home.file.".icons/Simp1e-breeze".source = ../home/.icons/Simp1e-breeze;
  home.file.".icons/DMZ-White-Highlighted".source =
    ../home/.icons/DMZ-White-Highlighted;

  # --------------------------------------------------------------------------
  # Wallpapers / screenlock image
  # --------------------------------------------------------------------------
  home.file."Pictures/wallpapers".source  = ../home/Pictures/wallpapers;
  home.file.".screenlock".source          = ../home/.screenlock;

  # --------------------------------------------------------------------------
  # make packages managed by NIX available to Sway
  # --------------------------------------------------------------------------
  systemd.user.sessionVariables = {
    PATH = "$HOME/.nix-profile/bin:$HOME/.local/bin:/nix/var/nix/profiles/default/bin:/usr/local/sbin:/usr/local/bin:/usr/bin";
  };

}
