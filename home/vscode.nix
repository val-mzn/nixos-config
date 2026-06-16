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
        ms-dotnettools.csharp
        ms-dotnettools.vscode-dotnet-runtime
        catppuccin.catppuccin-vsc
      ];

      userSettings = {
        "editor.fontSize" = 14;
        "window.zoomLevel" = 1;
        "editor.formatOnSave" = true;
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "workbench.colorTheme" = "Catppuccin Macchiato";
        "terminal.integrated.profiles.linux" = {
          "zsh".path = "/etc/profiles/per-user/valmzn/bin/zsh";
        };
        "dotnet.dotnetPath" = "/etc/profiles/per-user/valmzn/bin/dotnet";
        "omnisharp.useModernNet" = true;
      };
    };
  };
}
