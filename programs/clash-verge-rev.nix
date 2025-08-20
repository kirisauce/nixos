{ pkgs, lib, ... }:

{
  programs.clash-verge = {
    enable = true;
    tunMode = true;
    serviceMode = true;
    package = pkgs.clash-verge-rev;
    autoStart = true;
    # package = pkgs.clash-nyanpasu;
  };
}
