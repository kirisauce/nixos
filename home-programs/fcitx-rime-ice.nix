{ lib, pkgs, config, ... }:

{
  options.myConfig.fcitxRimeIce.enable = lib.mkEnableOption "fcitx5 RIME-ice pinyin input method";

  config = lib.mkIf config.myConfig.fcitxRimeIce.enable (let
    rime-ice-pkg = pkgs.callPackage ../pkgs/fcitx-rime-ice.nix {};
  in
  {
    home.packages = [ rime-ice-pkg ];

    home.file."/.local/share/fcitx5/rime" = {
      enable = true;
      source = builtins.toPath (lib.getLib rime-ice-pkg);
      recursive = true;
    };
  }
  );
}
