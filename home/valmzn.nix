{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./packages.nix
    ./terminal.nix
    ./hyprland.nix
  ];

  home.username = "valmzn";
  home.homeDirectory = "/home/valmzn";

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
