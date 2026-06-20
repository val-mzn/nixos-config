{
  config,
  lib,
  pkgs,
  ...
}:

let
  bentoDir = "/var/lib/bento";
  bentoRepo = "https://github.com/migueravila/Bento.git";
in
{
  systemd.services.bento-fetch = {
    description = "Clone migueravila/Bento source if missing";
    wantedBy = [ "multi-user.target" ];
    before = [ "docker-bento.service" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    path = [
      pkgs.git
      pkgs.coreutils
    ];
    script = ''
      if [ ! -f ${bentoDir}/index.html ]; then
        mkdir -p ${bentoDir}
        git clone --depth=1 ${bentoRepo} /tmp/bento-clone
        cp -r /tmp/bento-clone/. ${bentoDir}/
        rm -rf /tmp/bento-clone
        chmod -R a+rX ${bentoDir}
      fi
    '';
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers.bento = {
      image = "nginx:alpine";
      ports = [ "127.0.0.1:3000:80" ];
      volumes = [
        "${bentoDir}:/usr/share/nginx/html:ro"
      ];
      autoStart = true;
    };
  };

  environment.persistence."/persist".directories = [
    "/var/lib/docker"
    bentoDir
  ];
}
