{
  config,
  lib,
  pkgs,
  ...
}:

# Config based on https://github.com/brunoanesio/waybar-config
# (Catppuccin Mocha theme), adapted to this setup: uses swaync for
# notifications and `hyprctl dispatch exit` for the power button.

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
          "custom/notification"
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

        "custom/notification" = {
          tooltip-format = "Notifications ({} unread)";
          format = "{icon} {}";
          format-icons = {
            notification = "<span foreground='#eb6f92'><sup></sup></span>";
            none = "󰎡";
            dnd-notification = "<span foreground='#eb6f92'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='#eb6f92'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='#eb6f92'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        "custom/power" = {
          tooltip = false;
          on-click = "hyprctl dispatch exit";
          format = "⏻";
        };
      };
    };

    style = builtins.readFile ../configs/waybar/style.css;
  };
}
