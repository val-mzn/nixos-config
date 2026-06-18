{
  config,
  lib,
  pkgs,
  ...
}:

let
  wallpaper = "${config.home.homeDirectory}/.dotfiles/wallpaper/river.jpg";
in
{
  # NOTE: in nixpkgs 26.05, `pkgs.swww` ships the `awww` fork (binaries are
  # `awww` / `awww-daemon`, CLI-compatible with swww). hyprpaper 0.8.4 was
  # broken in this environment (config directives never applied), hence swww/awww.
  home.packages = [ pkgs.swww ];

  systemd.user.services.swww = {
    Unit = {
      Description = "awww/swww wallpaper daemon";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.swww}/bin/awww-daemon";
      # Wait for the daemon's socket to be ready, then set the wallpaper.
      ExecStartPost = "${pkgs.bash}/bin/bash -c 'until ${pkgs.swww}/bin/awww query >/dev/null 2>&1; do sleep 0.2; done; ${pkgs.swww}/bin/awww img ${wallpaper}'";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
