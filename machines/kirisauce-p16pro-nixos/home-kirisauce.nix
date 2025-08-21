{ config, pkgs, ... }:

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
        path = "~/wallpaper.webp";
      }
    ];
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
    fastfetch
    imagemagick
    godot
    obs-studio

    python313
    python313Packages.ipython

    fnm

    papirus-icon-theme
  ];

  programs.chromium.enable = true;

  programs.git = {
    enable = true;
    userEmail = "kirisauce@163.com";
    userName = "kirisauce";
  };
  programs.home-manager.enable = true;

  home.stateVersion = "25.05";
}
