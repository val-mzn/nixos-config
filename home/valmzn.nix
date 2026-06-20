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
    ./hyprlock.nix
    ./wofi.nix
    ./awww.nix
    ./vscode.nix
    ./firefox.nix
    ./waybar.nix
    ./swaync.nix
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

      @define-color sidebar_fg_color #e0def4;
      @define-color sidebar_backdrop_color #26233a;
      @define-color sidebar_shade_color #1f1d2e;
      @define-color secondary_sidebar_bg_color #26233a;
      @define-color secondary_sidebar_fg_color #e0def4;
      @define-color secondary_sidebar_backdrop_color #26233a;
      @define-color secondary_sidebar_shade_color #1f1d2e;
      @define-color dialog_bg_color #1f1d2e;
      @define-color dialog_fg_color #e0def4;
      @define-color thumbnail_bg_color #26233a;
      @define-color thumbnail_fg_color #e0def4;
      @define-color shade_color rgba(0,0,0,0.36);
      @define-color scrollbar_outline_color rgba(0,0,0,0.5);
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
