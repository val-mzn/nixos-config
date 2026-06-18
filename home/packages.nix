{
  config,
  lib,
  pkgs,
  ...
}:

{

  home.packages = with pkgs; [
    mako
    hyprpaper
    grim
    slurp
    wl-clipboard
    brightnessctl
    pavucontrol
    discord
    nixfmt
    claude-code
    font-awesome
    nerd-fonts.jetbrains-mono
    hyfetch
    fastfetch
    proton-vpn
    nautilus
  ];
}
