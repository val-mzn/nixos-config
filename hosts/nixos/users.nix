{
  config,
  lib,
  pkgs,
  ...
}:

{

  users.users.valmzn = {
    isNormalUser = true;
    description = "valmzn";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;
}
