{
  config,
  lib,
  pkgs,
  ...
}:

{
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    # Sous Hyprland, le portail hyprland ne fournit pas l'interface Settings
    # (celle que libadwaita/Nautilus lit pour le mode sombre) : on la route
    # explicitement vers le backend GTK.
    config.common = {
      default = [
        "hyprland"
        "gtk"
      ];
      "org.freedesktop.impl.portal.Settings" = [ "gtk" ];
    };
  };
}
