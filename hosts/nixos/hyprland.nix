{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.hyprland.enable = true;
  services.gvfs.enable = true;
  programs.dconf.enable = true;
  programs.nix-ld.enable = true;
}
