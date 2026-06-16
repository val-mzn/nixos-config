{
  config,
  lib,
  pkgs,
  ...
}:

{

  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";
}
