{ pkgs, lib, config, ... }:

{
  options.myConfig.hyprlock = {
    enable = lib.mkEnableOption "hyprlock";
    backgroundImage = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
    };
  };

  config = lib.mkIf config.myConfig.hyprlock.enable {
    programs.hyprlock.enable = lib.mkDefault true;
    programs.hyprlock.settings = (import ../config/hypr/hyprlock.nix) config.myConfig.hyprlock;
  };
}