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

  # ReGreet (GTK) avec thème Rosé Pine.
  # Le module programs.regreet configure greetd + cage automatiquement.
  programs.regreet = {
    enable = true;
    settings = {
      background = {
        path = "/etc/greetd/wallpaper.jpg";
        fit = "Cover";
      };
      GTK = {
        application_prefer_dark_theme = lib.mkForce true;
        theme_name = lib.mkForce "rose-pine";
        icon_theme_name = lib.mkForce "Papirus-Dark";
        cursor_theme_name = lib.mkForce "BreezeX-RosePineDawn-Linux";
        font_name = lib.mkForce "Inter 12";
      };
      commands = {
        reboot = [
          "systemctl"
          "reboot"
        ];
        poweroff = [
          "systemctl"
          "poweroff"
        ];
      };
    };
  };

  # Wallpaper accessible par le user système `greeter`.
  environment.etc."greetd/wallpaper.jpg".source = ../../wallpaper/imgur.jpg;

  # Le user système `greeter` doit voir les thèmes : installer côté système.
  environment.systemPackages = with pkgs; [
    rose-pine-gtk-theme
    papirus-icon-theme
    rose-pine-cursor
    inter
  ];

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
