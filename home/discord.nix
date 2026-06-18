{
  lib,
  pkgs,
  ...
}:

let
  rose-pine = pkgs.fetchurl {
    url = "https://github.com/rose-pine/discord/releases/download/v0.0.1/rose-pine.css";
    hash = "sha256-Hk3/GqUKCj6i1h8bckqaBdQxFN3r8zQD58MEPttMSpE=";
  };
in
{
  home.packages = [ pkgs.vesktop ];
  xdg.configFile."vesktop/themes/rose-pine.css".source = rose-pine;

  home.activation.vencordEnableTheme = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    settings="$HOME/.config/vesktop/settings/settings.json"
    if [ ! -f "$settings" ]; then
      run mkdir -p "$(dirname "$settings")"
      run cp ${
        pkgs.writeText "vencord-settings.json" (
          builtins.toJSON {
            enabledThemes = [ "rose-pine.css" ];
          }
        )
      } "$settings"
      run chmod u+w "$settings"
    fi
  '';
}
