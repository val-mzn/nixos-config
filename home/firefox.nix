{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.firefox = {
    enable = true;

    profiles.valmzn = {
      isDefault = true;

      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        darkreader
      ];
    };
  };
}
