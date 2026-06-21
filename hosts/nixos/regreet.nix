{
  config,
  lib,
  pkgs,
  ...
}:

{
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
}
