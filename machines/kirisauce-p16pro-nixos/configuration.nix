{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../system/openssh.nix
    ../../system/pipewire.nix
    #../../system/plasma.nix
    ../../system/sddm.nix
    ../../system/resolved.nix
    ../../programs/hyprland.nix
    ../../programs/librime.nix
    ../../programs/clash-verge-rev.nix
    ../../configuration.nix
  ];

  myConfig.librime.lua.enable = true;

  environment.systemPackages = with pkgs; [
    qq
    wechat-uos
    telegram-desktop

    ffmpeg-full

    rustup
  ];

  environment.shells = [
    pkgs.zsh
  ];

  programs.zsh.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    gcc
    vulkan-loader
    mesa
    glibc
    fontconfig
  ];

  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    cascadia-code
    maple-mono.NF-CN
    nerd-fonts.fantasque-sans-mono
    lxgw-wenkai
  ];

  users.users.kirisauce = {
    uid = 1000;
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel" # Enable sudo for the user.
      "networkmanager"
      "uucp" # To access USB device
      "input" # Input devices
    ];
  };

  networking.hostName = "kirisauce-p16pro-nixos";
}
