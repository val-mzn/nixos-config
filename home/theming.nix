{
  config,
  lib,
  pkgs,
  ...
}:

{
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
    ''
    + builtins.readFile ../configs/gtk/gtk.css;

    "Kvantum/rose-pine".source = "${pkgs.rose-pine-kvantum}/share/Kvantum/themes/rose-pine";
    "Kvantum/kvantum.kvconfig".source = ../configs/kvantum/kvantum.kvconfig;
  };
}
