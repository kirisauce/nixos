{ pkgs, lib, ... }:

{
  imports = [
    ../components/desktop-common.nix
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  gsettings-schemas.enable = lib.mkDefault true;
  gsettings-schemas.packages = with pkgs; [
    libgnomekbd
    gnome-settings-daemon
    libgweather
  ];
}
