# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [
    ./system/grub.nix
    ./system/hostname.nix
    ./system/nix-settings.nix
    ./modules
  ];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "zh_CN.UTF-8";

  environment.systemPackages = with pkgs; [
    # Common unix cmdline tools
    ripgrep
    fd
    eza

    # Network tools
    wget
    curl
    traceroute
    socat
    openssh

    # System information tools
    lshw
    inxi
    lsof
    coreutils
    btop
    htop
    smartmontools

    # Compress & Package tools
    lz4
    gzip
    xz
    zstd
    gnutar
    zip
    unzip
    p7zip

    # Other tools
    patchelf
    gdu
    neovim
    file
    direnv
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  nixpkgs.config.allowUnfree = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

