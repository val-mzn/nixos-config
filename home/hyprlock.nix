{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        grace = 0;
        disable_loading_bar = true;
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
          color = "rgb(191d2e)";
        }
      ];

      input-field = [
        {
          size = "250, 50";
          position = "0, -80";
          halign = "center";
          valign = "center";
          outline_thickness = 2;
          dots_size = 0.25;
          dots_spacing = 0.3;
          dots_center = true;
          rounding = 12;

          # Rosé Pine
          outer_color = "rgb(31748f)"; # pine
          inner_color = "rgb(26233a)"; # surface
          font_color = "rgb(e0def4)"; # text
          check_color = "rgb(ebbcba)"; # rose
          fail_color = "rgb(eb6f92)"; # love

          placeholder_text = "<span foreground='##908caa'>Password...</span>";
          fail_text = "<span foreground='##eb6f92'>$FAIL</span>";
        }
      ];

      label = [
        {
          # Clock
          text = "$TIME";
          color = "rgb(e0def4)";
          font_size = 64;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
        {
          # User
          text = "  $USER";
          color = "rgb(908caa)";
          font_size = 16;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, -20";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
