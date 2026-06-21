{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./packages.nix
    ./fish.nix
    ./starship.nix
    ./kitty.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./wofi.nix
    ./awww.nix
    ./vscode.nix
    ./firefox.nix
    ./waybar.nix
    ./swaync.nix
    ./spicetify.nix
    ./discord.nix
    ./theming.nix
    ./mime.nix
  ];

  home.username = "valmzn";
  home.homeDirectory = "/home/valmzn";

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
