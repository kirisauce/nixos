{ pkgs, lib, config, ... }:

{
  options.myConfig.librime.lua.enable = lib.mkEnableOption "lua support for librime";

  config.nixpkgs.overlays = lib.mkIf config.myConfig.librime.lua.enable [
    (final: prev: with pkgs; {
      librime = (prev.librime.override {
        plugins = [
          librime-lua
          # librime-octagram
        ];
      }).overrideAttrs (old: {
        buildInputs = (old.buildInputs or []) ++ [ lua5_4 ];
        # buildInputs = (old.buildInputs or []) ++ [ luajit ];
      });
    })
  ];
}
