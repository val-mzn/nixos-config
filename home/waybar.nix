{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 36;
        margin-left = 0;
        margin-right = 0;

        modules-left = [
          "clock"
          "wlr/taskbar"
        ];

        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "tray"
          "wireplumber"
          "wireplumber#source"
          "cpu"
          "memory"
          "disk"
          "temperature"
          "network"
          "custom/power"
        ];

        clock = {
          format = "  {:%H:%M}";
          format-alt = "  {:%a %d %b %Y}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };

        "wlr/taskbar" = {
          format = "{icon}";
          icon-size = 16;
          all-outputs = true;
          tooltip-format = "{name}: {title}";
          on-click = "activate";
          on-click-middle = "close";
        };

        # ── Center ────────────────────────────────────────────
        "hyprland/workspaces" = {
          all-outputs = true;
          format = "{id}";
          on-click = "activate";
        };

        # ── Right ─────────────────────────────────────────────
        tray = {
          icon-size = 14;
          spacing = 10;
        };

        wireplumber = {
          format = " {icon} ";
          format-muted = "   ";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-scroll-up = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
          on-scroll-down = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-";
          scroll-step = 5;
          format-icons = {
            headphone = "";
            headset = "";
            default = [
              ""
              ""
              ""
            ];
          };
          tooltip = true;
          tooltip-format = "{icon}  at {volume}%";
        };

        "wireplumber#source" = {
          format = " {format_source}";
          format-source = "";
          format-source-muted = "";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          on-scroll-up = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SOURCE@ 5%+";
          on-scroll-down = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SOURCE@ 5%-";
          scroll-step = 5;
          tooltip = true;
          tooltip-format = "  at {volume}%";
        };

        cpu = {
          interval = 10;
          format = "󰻠 {usage}%";
          format-alt = "󰻠 {usage}%";
          max-length = 10;
        };

        memory = {
          interval = 30;
          format = "󰍛 {}%";
          format-alt = "󰍛 {}%";
          max-length = 10;
          tooltip = true;
          tooltip-format = "Memory - {used:0.1f}GB used";
        };

        disk = {
          interval = 600;
          format = "󰋊";
          path = "/";
          format-alt = "󰋊 {percentage_used}%";
          tooltip = true;
          tooltip-format = "HDD - {used} used out of {total} on {path} ({percentage_used}%)";
          states = {
            warning = 85;
            critical = 90;
          };
        };

        temperature = {
          hwmon-path-abs = "/sys/devices/platform/coretemp.0/hwmon";
          input-filename = "temp1_input";
          format = "󰔏 {temperatureC}°C";
          format-alt = "󰔏 {temperatureC}°C";
          critical-threshold = 70;
          format-critical = "󰔏 {temperatureC}°C";
        };

        network = {
          format = "{ifname}";
          format-wifi = " ";
          format-ethernet = " ";
          format-disconnected = " ";
          tooltip-format = " {ifname} via {gwaddr}";
          tooltip-format-wifi = " {essid} ({signalStrength}%)";
          tooltip-format-ethernet = " {ifname} {ipaddr}/{cidr}";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
        };

        "custom/power" = {
          format = " ";
          on-click = "hyprctl dispatch exit";
          tooltip = false;
        };
      };
    };

    style = ''
      /* Colors (dracula) */
      @define-color foreground	#f8f8f2;
      @define-color background	rgba(40, 42, 54, 0.5);
      @define-color orange	#ffb86c;
      @define-color gray	#44475a;
      @define-color black #21222c;
      @define-color red	#ff5555;
      @define-color green	#50fa7b;
      @define-color yellow	#f1fa8c;
      @define-color cyan	#8be9fd;
      @define-color blue	#6272a4;
      @define-color purple	#bd93f9;
      @define-color pink	#ff79c6;
      @define-color white #ffffff;
      @define-color brred #ff6e6e;

      @define-color arch_blue #89b4fa;

      @define-color workspace_active_background	@green;
      @define-color workspace_active	@black;
      @define-color workspace_hover_background	@pink;
      @define-color workspace_hover	@black;
      @define-color workspace_urgent_background	@brred;
      @define-color workspace_urgent	@white;
      @define-color critical	@red;
      @define-color warning	@yellow;

      @keyframes blink {
          to {
              background-color: @white;
              color: @black;
          }
      }

      * {
          border: none;
          border-radius: 0;
          font-family: "JetBrainsMono Nerd Font", "monospace";
          font-weight: bold;
          font-size: 16px;
          min-height: 0;
      }

      window#waybar {
          background: transparent;
          color: @foreground;
      }

      #workspaces {
          background: @background;
          opacity: 1;
          transition: none;
          padding: 5px 5px;
          border-radius: 5px;
      }

      #workspaces button,
      #workspaces button.empty {
          background: transparent;
          color: @blue;
          border-radius: 5px;
          padding: 0 6px;
          min-width: 18px;
          transition: none;
      }

      #workspaces button.active {
          background: @workspace_active_background;
          color: @workspace_active;
          border-radius: 5px;
          border-bottom: 2px solid @pink;
      }

      #workspaces button.urgent {
          background: @workspace_urgent_background;
          color: @workspace_urgent;
          border-radius: 5px;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #workspaces button:hover {
          background: @workspace_hover_background;
          color: @workspace_hover;
          border-radius: 5px;
      }

      #taskbar {
          background: @background;
          border-radius: 5px;
          margin: 5px 10px 5px 50px;
      }

      tooltip {
          background: @background;
          opacity: 0.95;
          border-radius: 10px;
          border-width: 2px;
          border-style: solid;
          border-color: @purple;
      }

      tooltip label {
          color: @foreground;
      }

      #custom-launcher,
      #custom-power,
      #cpu,
      #disk,
      #memory,
      #clock,
      #network,
      #tray,
      #temperature,
      #wireplumber {
          background: @background;
          opacity: 1;
          padding: 0px 8px;
          margin: 2px 0px 2px 0px;
      }

      #disk.critical,
      #temperature.critical {
          background-color: @critical;
      }

      #disk.warning,
      #temperature.warning {
          background-color: @warning;
      }

      #custom-launcher {
          color: @arch_blue;
          border-radius: 5px 0px 0px 5px;
      }

      #custom-power {
          color: @red;
          border-radius: 0px 5px 5px 0px;
      }

      #clock {
          border-radius: 5px;
      }

      #tray {
          background: @background;
          border-radius: 5px;
          margin: 5px 50px 5px 10px;
      }

      #wireplumber.source {
          background: @background;
      }
    '';
  };
}
