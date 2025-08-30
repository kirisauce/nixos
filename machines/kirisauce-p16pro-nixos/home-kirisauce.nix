{ config, pkgs, ... }:

let
  wallpaper = "~/wallpaper.webp";
in
{
  imports = [
    ../../home-programs
  ];

  # For hyprland monitor configuration
  myConfig.hyprland = {
    enable = true;

    monitors = [
      {
        output = "eDP-1";
        mode = "2560x1600@165.00";
        position = "0x0";
        scale = 1.25;
      }
    ];

    inputMethod.enable = true;
    waybarIntegration = true;
    nvidiaCompatible = true;
    hyprshot.enable = true;
    hyprlock.enable = true;

    # Xwayland applications scale
    extraExecOnce = [
      "hyprpaper"
      ''echo "Xft.dpi: 120" | xrdb -merge''
    ];

    uwsmWrapper.enable = false;
  };

  myConfig.hyprpaper = {
    enable = true;
    wallpapers = [
      {
        output = "eDP-1";
        path = wallpaper;
      }
    ];
  };

  myConfig.hyprlock = {
    enable = true;
    backgroundImage = wallpaper;
  };

  myConfig = {
    forceXdgDirsEnglish = true;
    waybar.enable = true;
    zshPretty.enable = true;
    fcitx5-rime.enable = true;
    fcitxRimeIce.enable = true;
    kitty.enable = true;

    fnm = {
      enable = true;
      zsh-integration = true;
    };
  };
    

  home.username = "kirisauce";
  home.homeDirectory = "/home/kirisauce";

  home.packages = with pkgs; [
    vscode-fhs
    helix
    fastfetch
    imagemagick
    exiftool
    godot
    obs-studio

    python313
    python313Packages.ipython
    python313Packages.pip

    fnm

    papirus-icon-theme
  ];

  home.pointerCursor = {
    name = "phinger-cursors-dark";
    package = pkgs.phinger-cursors;
    size = 32;
    gtk.enable = true;
    x11.enable = true;
  };

  programs.chromium.enable = true;

  programs.git = {
    enable = true;
    userEmail = "kirisauce@163.com";
    userName = "kirisauce";
  };
  programs.home-manager.enable = true;

  home.stateVersion = "25.05";
}
