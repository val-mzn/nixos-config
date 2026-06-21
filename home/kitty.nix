{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      font_family = "JetBrainsMono Nerd Font";
      font_size = 14.0;
      dynamic_background_opacity = true;
    };

    extraConfig = builtins.readFile ../configs/kitty/kitty.conf;
  };
}
