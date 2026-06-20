{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./packages.nix
    ./terminal.nix
    ./hyprland.nix
    ./wofi.nix
    ./awww.nix
    ./vscode.nix
    ./firefox.nix
    ./waybar.nix
    ./spicetify.nix
    ./discord.nix
  ];

  home.username = "valmzn";
  home.homeDirectory = "/home/valmzn";

  programs.home-manager.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "BreezeX-RosePine-Linux";
    size = 24;
    package = pkgs.rose-pine-cursor;
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  gtk = {
    enable = true;
    theme = {
      name = "rose-pine";
      package = pkgs.rose-pine-gtk-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  xdg.configFile = {
    "gtk-4.0/gtk.css".text = ''
      @import url("file://${pkgs.rose-pine-gtk-theme}/share/themes/rose-pine/gtk-4.0/gtk.css");
    '';

    "Kvantum/rose-pine".source = "${pkgs.rose-pine-kvantum}/share/Kvantum/themes/rose-pine";
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=rose-pine
    '';
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "org.gnome.Nautilus.desktop";

      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
      "application/xhtml+xml" = "firefox.desktop";
    };
  };

  home.stateVersion = "26.05";
}
