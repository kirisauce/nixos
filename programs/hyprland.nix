{ pkgs, lib, ... }:

{
  imports = [
    ../components/desktop-common.nix
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Driver mounting
  services.gvfs.enable = true;

  # Polkit client
  security.soteria.enable = true;

  gsettings-schemas.enable = lib.mkDefault true;
  gsettings-schemas.packages = with pkgs; [
    libgnomekbd
    gnome-settings-daemon
    libgweather
  ];
}
