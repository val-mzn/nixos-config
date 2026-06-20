{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Avec impermanence, /etc/shadow est recréé à chaque boot depuis les fichiers
  # dans /persist/passwords/ — les changements manuels de mot de passe ne survivent pas au reboot.
  users.mutableUsers = false;

  users.users.root = {
    hashedPasswordFile = "/persist/passwords/root";
  };

  users.users.valmzn = {
    isNormalUser = true;
    description = "valmzn";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    shell = pkgs.fish;
    hashedPasswordFile = "/persist/passwords/valmzn";
  };

  programs.fish.enable = true;

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };
}
