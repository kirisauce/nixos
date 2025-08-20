{ pkgs, ... }:

{
  services = {
    desktopManager.plasma6.enable = true;
    libinput.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    oxygen
    kdepim-runtime
    konsole
  ];
}
