{ pkgs, lib, config, ... }:

{
  options.myConfig.waybar.enable = lib.mkEnableOption "custom waybar config";

  config = lib.mkIf config.myConfig.waybar.enable {
    home.packages = [ pkgs.waybar ];

    home.file."/.config/waybar" = {
      enable = true;
      # source = ./waybar-config;
      source = config.lib.file.mkOutOfStoreSymlink ../config/waybar;
      recursive = true;
    };
  };
}
