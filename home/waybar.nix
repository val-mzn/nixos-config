{
  config,
  lib,
  pkgs,
  ...
}:

# Config based on https://github.com/brunoanesio/waybar-config
# (Catppuccin Mocha theme), adapted to this setup: keeps mako for
# notifications and uses `hyprctl dispatch exit` for the power button.

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        height = 40;
        spacing = 2;
        exclusive = true;
        gtk-layer-shell = true;
        passthrough = false;
        fixed-center = true;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];

        modules-center = [
          "mpris"
        ];

        modules-right = [
          "cpu"
          "memory"
          "pulseaudio"
          "clock"
          "clock#simpleclock"
          "tray"
          "custom/power"
        ];

        mpris = {
          player = "spotify";
          dynamic-order = [
            "artist"
            "title"
          ];
          format = "{player_icon} {dynamic}";
          format-paused = "{status_icon} <i>{dynamic}</i>";
          status-icons = {
            paused = "";
          };
          player-icons = {
            default = "";
          };
        };

        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{id}";
          all-outputs = true;
          disable-scroll = false;
          active-only = false;
        };

        "hyprland/window" = {
          format = "{title}";
        };

        tray = {
          show-passive-items = true;
          spacing = 10;
        };

        "clock#simpleclock" = {
          tooltip = false;
          format = " {:%H:%M}";
        };

        clock = {
          format = " {:L%a %d %b}";
          calendar = {
            format = {
              days = "<span weight='normal'>{}</span>";
              months = "<span color='#e0def4'><b>{}</b></span>";
              today = "<span color='#eb6f92' weight='700'><u>{}</u></span>";
              weekdays = "<span color='#f6c177'><b>{}</b></span>";
              weeks = "<span color='#9ccfd8'><b>W{}</b></span>";
            };
            mode = "month";
            mode-mon-col = 1;
            on-scroll = 1;
          };
          tooltip-format = "<span color='#e0def4' font='Lexend 16'><tt><small>{calendar}</small></tt></span>";
        };

        cpu = {
          format = " {usage}%";
          tooltip = true;
          interval = 1;
        };

        memory = {
          format = " {used:0.1f}Gi";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "  muted";
          format-icons = {
            headphone = "";
            default = [
              " "
              " "
              " "
            ];
          };
          on-click = "pavucontrol";
        };

        "custom/power" = {
          tooltip = false;
          on-click = "hyprctl dispatch exit";
          format = "⏻";
        };
      };
    };

    style = ''
      /* Rosé Pine — https://github.com/rose-pine/waybar */
      @define-color base          #191724;
      @define-color surface       #1f1d2e;
      @define-color overlay       #26233a;
      @define-color muted         #6e6a86;
      @define-color subtle        #908caa;
      @define-color text          #e0def4;
      @define-color love          #eb6f92;
      @define-color gold          #f6c177;
      @define-color rose          #ebbcba;
      @define-color pine          #31748f;
      @define-color foam          #9ccfd8;
      @define-color iris          #c4a7e7;
      @define-color highlightLow  #21202e;
      @define-color highlightMed  #403d52;
      @define-color highlightHigh #524f67;

      * {
        min-height: 0;
        min-width: 0;
        font-family: Lexend, "JetBrainsMono NFP";
        font-size: 16px;
        font-weight: 600;
      }

      window#waybar {
        transition-property: background-color;
        transition-duration: 0.5s;
        background-color: @base;
      }

      #workspaces button {
        padding: 0.3rem 0.6rem;
        margin: 0.4rem 0.25rem;
        border-radius: 6px;
        background-color: @surface;
        color: @text;
      }

      #workspaces button:hover {
        color: @base;
        background-color: @text;
      }

      #workspaces button.active {
        background-color: @surface;
        color: @foam;
      }

      #workspaces button.urgent {
        background-color: @surface;
        color: @love;
      }

      #clock,
      #pulseaudio,
      #custom-logo,
      #custom-power,
      #custom-spotify,
      #custom-notification,
      #cpu,
      #tray,
      #memory,
      #window,
      #mpris {
        padding: 0.3rem 0.6rem;
        margin: 0.4rem 0.25rem;
        border-radius: 6px;
        background-color: @surface;
      }

      #mpris.playing {
        color: @foam;
      }

      #mpris.paused {
        color: @muted;
      }

      #custom-sep {
        padding: 0px;
        color: @highlightHigh;
      }

      window#waybar.empty #window {
        background-color: transparent;
      }

      #cpu {
        color: @foam;
      }

      #memory {
        color: @iris;
      }

      #clock {
        color: @rose;
      }

      #clock.simpleclock {
        color: @foam;
      }

      #window {
        color: @text;
      }

      #pulseaudio {
        color: @iris;
      }

      #pulseaudio.muted {
        color: @subtle;
      }

      #custom-logo {
        color: @foam;
      }

      #custom-power {
        color: @love;
      }

      tooltip {
        background-color: @surface;
        border: 2px solid @foam;
      }
    '';
  };
}
