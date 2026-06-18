{
  config,
  lib,
  pkgs,
  ...
}:

{

  programs.hyprland.enable = true;

  # Backend requis par Nautilus (corbeille, montage USB/réseau, miniatures)
  services.gvfs.enable = true;

  # Requis pour que la préférence color-scheme (mode sombre) soit appliquée
  programs.dconf.enable = true;

  programs.nix-ld.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
  };

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
      user = "greeter";
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    # Sous Hyprland, le portail hyprland ne fournit pas l'interface Settings
    # (celle que libadwaita/Nautilus lit pour le mode sombre) : on la route
    # explicitement vers le backend GTK.
    config.common = {
      default = [ "hyprland" "gtk" ];
      "org.freedesktop.impl.portal.Settings" = [ "gtk" ];
    };
  };
}
