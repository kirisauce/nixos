{ config, lib, pkgs, ... }:

let
  defaultWallpaperPath = "~/.";
in
{
  options = {
    myConfig.hyprpaper.enable = lib.mkEnableOption "Custom hyprpaper config";

    myConfig.hyprpaper.wallpapers = lib.mkOption {
      description = "Hyprpaper wallpapers";
      default = [];
      example = [
        {
	  output = "DP-1";
	  path = "/share/wallpapers/unx.png";
	}
        {
	  output = "DP-3";
	  path = "/share/wallpapers/xun.png";
	}
      ];
    };
  };

  config = with config.myConfig.hyprpaper; lib.mkIf enable {
    home.packages = [ pkgs.hyprpaper ];

    services.hyprpaper = {
      enable = true;
    };

    services.hyprpaper.settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = builtins.map (x: x.path) wallpapers;

      wallpaper = builtins.map (x: "${x.output},${x.path}") wallpapers;
    };

    
  };
}
