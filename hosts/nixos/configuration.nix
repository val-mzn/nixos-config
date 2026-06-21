{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ./impermanence.nix
    ./boot.nix
    ./networking.nix
    ./locale.nix
    ./users.nix
    ./nvidia.nix
    ./hyprland.nix
    ./steam.nix
    ./regreet.nix
    ./xdg-portal.nix
    ./audio.nix
    ./packages.nix
    ./docker.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05";
}
