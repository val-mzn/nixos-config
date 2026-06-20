{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.vscode = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        anthropic.claude-code
        jnoortheen.nix-ide
        mvllow.rose-pine
        vscode-icons-team.vscode-icons
      ];

      userSettings = {
        "editor.fontSize" = 14;
        "window.zoomLevel" = 1;
        "editor.formatOnSave" = true;
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = lib.getExe pkgs.nil;
        "workbench.colorTheme" = "Rosé Pine";
        "workbench.iconTheme" = "vscode-icons";
      };
    };
  };
}
