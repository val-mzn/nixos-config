{
  config,
  lib,
  pkgs,
  ...
}:

{

  home.packages = with pkgs; [
    wofi
    mako
    hyprpaper
    grim
    slurp
    wl-clipboard
    brightnessctl
    pavucontrol
  ];

  programs.waybar.enable = true;
}
