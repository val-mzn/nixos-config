{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = lib.importTOML ../configs/starship/starship.toml;
  };
}
