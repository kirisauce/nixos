{ ... }:

{
  imports = [
    ../components/desktop-common.nix
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
