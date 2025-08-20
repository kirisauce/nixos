{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    glib
    dconf-editor
    gsettings-desktop-schemas
    kdePackages.ark
  ];
}
