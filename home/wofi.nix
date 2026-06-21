{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.wofi = {
    enable = true;

    settings = {
      show = "drun";
      allow_images = true;
      insensitive = true;
    };

    # Rosé Pine (main) — https://github.com/cement-drinker/wofi-rose-pine
    style = builtins.readFile ../configs/wofi/style.css;
  };
}
