{ config, lib, pkgs, ... }:

{
  options.myConfig.kitty.enable = lib.mkEnableOption "custom kitty config";

  config = lib.mkIf config.myConfig.kitty.enable {
    home.file."/.config/kitty" = {
      enable = true;
      source = ../config/kitty;
      recursive = true;
    };
  };
}
