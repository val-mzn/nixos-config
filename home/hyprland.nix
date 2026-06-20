{
  config,
  lib,
  pkgs,
  ...
}:

{

  # Palette Rosé Pine (https://github.com/rose-pine/hyprland)
  xdg.configFile."hypr/rose-pine.conf".source = ../configs/rose-pine.config;

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
    settings = {
      source = "~/.config/hypr/rose-pine.conf";

      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$menu" = "wofi --show drun";
      "$fileManager" = "nautilus";

      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "NIXOS_OZONE_WL,1"
        "XCURSOR_THEME,BreezeX-RosePine-Linux"
        "XCURSOR_SIZE,24"
        "GTK_THEME,rose-pine"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_STYLE_OVERRIDE,kvantum"
      ];

      exec-once = [
        "waybar"
        "swaync"
      ];

      monitor = ",preferred,auto,1";

      input = {
        kb_layout = "us";
        follow_mouse = 1;
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
        "col.active_border" = "$pine $iris 45deg";
        "col.inactive_border" = "$highlightMed";
      };

      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 8;
          passes = 2;
          new_optimizations = true;
        };
      };

      animations = {
        enabled = true;
        bezier = "snappy, 0.25, 0.1, 0.25, 1";
        animation = [
          "windows, 1, 2, snappy"
          "windowsOut, 1, 2, snappy, popin 80%"
          "border, 1, 4, default"
          "fade, 1, 2, default"
          "workspaces, 1, 2, snappy"
        ];
      };

      bind = [
        "$mod, Return, exec, $terminal"
        "$mod, Q, killactive,"
        "$mod, M, exit,"
        "$mod, E, exec, $menu"
        "$mod SHIFT, E, exec, $fileManager"
        "$mod, V, togglefloating,"
        "$mod, F, fullscreen,"
        "$mod, C, centerwindow,"
        "$mod, P, pin,"
        "$mod, L, exec, hyprlock"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"

        "$mod, S, exec, grim -g \"$(slurp)\" - | wl-copy"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      binde = [
        "$mod CTRL, left, resizeactive, -40 0"
        "$mod CTRL, right, resizeactive, 40 0"
        "$mod CTRL, up, resizeactive, 0 -40"
        "$mod CTRL, down, resizeactive, 0 40"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 5%-"
      ];

      bindl = [
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPrev, exec, playerctl previous"
      ];
    };
  };
}
