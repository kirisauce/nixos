{ pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      glib
      dconf-editor
      gsettings-desktop-schemas
      kdePackages.ark
    ];

    programs.dconf.enable = true;

    gsettings-schemas.packages = with pkgs; [
      gtk3
      gtk4
      gsettings-desktop-schemas
      dconf-editor
    ];
  };
}
