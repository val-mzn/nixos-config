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
      settings = {
        "ui.systemUsesDarkTheme" = 0;
        "browser.in-content.dark-mode" = false;

        "browser.startup.page" = 1;
        "browser.startup.homepage" = "http://localhost:3000";
        "browser.newtabpage.enabled" = true;
        "extensions.newTabOverride.newTabURL" = "http://localhost:3000";
      };
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        darkreader
        proton-pass
        new-tab-override
      ];

      search = {
        force = true;
        default = "Google";
        privateDefault = "Google";
        order = [ "Google" ];
        engines = {
          "Bing".metaData.hidden = true;
          "Amazon.com".metaData.hidden = true;
          "eBay".metaData.hidden = true;
          "DuckDuckGo".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;
        };
      };

      userChrome = builtins.readFile ../configs/firefox/userChrome.css;
    };
  };
}
