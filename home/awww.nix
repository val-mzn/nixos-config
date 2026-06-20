{
  config,
  lib,
  pkgs,
  ...
}:

let
  wallpaper = "${config.home.homeDirectory}/.dotfiles/wallpaper/imgur.jpg";
in
{
  home.packages = [ pkgs.awww ];

  systemd.user.services.swww = {
    Unit = {
      Description = "awww/swww wallpaper daemon";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.awww}/bin/awww-daemon";
      ExecStartPost = "${pkgs.bash}/bin/bash -c 'until ${pkgs.awww}/bin/awww query >/dev/null 2>&1; do sleep 0.2; done; ${pkgs.awww}/bin/awww img ${wallpaper}'";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
