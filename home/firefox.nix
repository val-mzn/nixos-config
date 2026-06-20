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
        default = "SearXNG";
        privateDefault = "SearXNG";
        order = [ "SearXNG" ];
        engines = {
          "SearXNG" = {
            urls = [
              {
                template = "http://localhost:8888/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "http://localhost:8888/static/themes/simple/img/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [
              "@sx"
              "@searx"
            ];
          };

          "Google".metaData.hidden = true;
          "Bing".metaData.hidden = true;
          "Amazon.com".metaData.hidden = true;
          "eBay".metaData.hidden = true;
          "DuckDuckGo".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;
        };
      };

      userChrome = ''
        :root {
          --rp-base:            #191724; /* frame / arrière-plan */
          --rp-surface:         #1f1d2e; /* toolbar / popup */
          --rp-overlay:         #26233a; /* champ d'URL */
          --rp-highlight-med:   #524f67; /* surbrillance champ */
          --rp-text:            #e0def4; /* texte toolbar */
          --rp-subtle:          #908caa; /* texte onglets inactifs */
          --rp-pine:            #31748f; /* ligne onglet actif */
          --rp-rose:            #ebbcba; /* icônes */
          --rp-love:            #eb6f92; /* icônes attention */

          --toolbar-bgcolor:    var(--rp-surface) !important;
          --toolbar-color:      var(--rp-text) !important;
          --toolbarbutton-icon-fill: var(--rp-rose) !important;
          --lwt-accent-color:   var(--rp-base) !important;
          --tab-selected-bgcolor: var(--rp-surface) !important;
        }

        #navigator-toolbox,
        #titlebar,
        .tabbrowser-tab {
          background-color: var(--rp-base) !important;
          color: var(--rp-subtle) !important;
        }

        #nav-bar,
        #PersonalToolbar {
          background-color: var(--rp-surface) !important;
          color: var(--rp-text) !important;
        }

        .tabbrowser-tab[selected] .tab-content {
          color: var(--rp-text) !important;
        }
        .tabbrowser-tab[selected] {
          box-shadow: 0 -2px 0 0 var(--rp-pine) inset !important;
        }

        #urlbar,
        #searchbar {
          background-color: var(--rp-overlay) !important;
          color: var(--rp-text) !important;
        }
        #urlbar[focused] {
          outline-color: var(--rp-highlight-med) !important;
        }
      '';
    };
  };
}
