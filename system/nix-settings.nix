{ config, lib, pkgs, ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = lib.mkForce [ "https://mirrors.ustc.edu.cn/nix-channels/store" ];
  };
}
