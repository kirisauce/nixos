{ pkgs, lib, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    enableHidpi = true;
    package = lib.mkForce pkgs.kdePackages.sddm;

    theme = "catppuccin-mocha";
  };

  environment.systemPackages = [
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      font  = "LXGW WenKai";
      fontSize = "9";
      background = "${../sddm-wallpaper.png}";
      loginBackground = true;
    })
  ];
}
