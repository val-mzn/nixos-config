{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.swaync = {
    enable = true;
    settings = builtins.fromJSON (builtins.readFile ../configs/swaync-config.json);
    style = ../configs/swaync-style.css;
  };
}
