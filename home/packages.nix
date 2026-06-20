{
  config,
  lib,
  pkgs,
  ...
}:

{

  home.packages = with pkgs; [
    hyprpaper
    grim
    slurp
    wl-clipboard
    brightnessctl
    pavucontrol
    discord
    nixfmt
    claude-code
    nodejs # requis par le skill/hooks caveman (exécutés via `node` à chaque session)
    font-awesome
    nerd-fonts.jetbrains-mono
    lexend
    playerctl
    hyfetch
    fastfetch
    proton-vpn
    proton-pass
    nautilus
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    rose-pine-cursor
    rose-pine-kvantum
  ];
}
