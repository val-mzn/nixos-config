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
    nodejs    # requis par le skill/hooks caveman (exécutés via `node` à chaque session)
    font-awesome
    nerd-fonts.jetbrains-mono
    lexend
    playerctl
    hyfetch
    fastfetch
    proton-vpn
    nautilus
  ];
}
