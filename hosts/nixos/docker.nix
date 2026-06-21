{
  config,
  lib,
  pkgs,
  ...
}:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
    daemon.settings = {
      log-driver = "journald";
    };
  };

  users.users.valmzn.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  environment.persistence."/persist".directories = [
    "/var/lib/docker"
  ];
}
