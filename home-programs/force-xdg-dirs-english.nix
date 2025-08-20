# Force XDG directories to be in English
{ config, lib, pkgs, ... }:

{
  options.myConfig.forceXdgDirsEnglish = lib.mkEnableOption "force XDG user directories to be in English";

  config = lib.mkIf config.myConfig.forceXdgDirsEnglish {
    home.file."/.config/user-dirs.locale" = {
      enable = true;
      source = ../config/user-dirs.locale;
    };

    home.file."/.config/user-dirs.dirs" = {
      enable = true;
      source = ../config/user-dirs.dirs;
    };
  };
}
