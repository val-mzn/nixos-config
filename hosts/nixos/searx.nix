{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.searx = {
    enable = true;
    package = pkgs.searxng;

    settings = {
      server = {
        port = 8888;
        bind_address = "127.0.0.1";
        secret_key = "@SEARX_SECRET@";
        limiter = false;
        image_proxy = true;
      };

      search = {
        safe_search = 0;
        autocomplete = "duckduckgo";
        default_lang = "fr";
        formats = [
          "html"
          "json"
        ];
      };

      ui = {
        default_theme = "simple";
        theme_args.simple_style = "dark";
      };

      general = {
        instance_name = "SearXNG (local)";
        privacypolicy_url = false;
        donation_url = false;
        contact_url = false;
      };
    };

    environmentFile = "/etc/searx/secret.env";
  };

  systemd.tmpfiles.rules = [
    "d /etc/searx 0750 searx searx -"
  ];

  system.activationScripts.searxSecret = ''
    if [ ! -f /etc/searx/secret.env ]; then
      mkdir -p /etc/searx
      umask 077
      printf 'SEARX_SECRET=%s\n' "$(${pkgs.openssl}/bin/openssl rand -hex 32)" > /etc/searx/secret.env
      chown searx:searx /etc/searx/secret.env || true
      chmod 0640 /etc/searx/secret.env
    fi
  '';
}
