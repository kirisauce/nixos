{ pkgs, lib, config, ... }:

{
  imports = [ ../programs/librime.nix ];

  options.myConfig.fcitx5-rime.enable = lib.mkEnableOption "fcitx5-rime";

  config = lib.mkIf config.myConfig.fcitx5-rime.enable {
    i18n.inputMethod = {
      type = "fcitx5";
      enable = true;
    };

    i18n.inputMethod.fcitx5 = {
      addons = with pkgs; [
        fcitx5-chinese-addons
        fcitx5-rime
        rime-data
        librime
        fcitx5-nord
        fcitx5-gtk
        kdePackages.fcitx5-qt
        kdePackages.fcitx5-with-addons
      ]
      ++ lib.optionals config.myConfig.librime.lua.enable [ librime-lua ];
      waylandFrontend = true;

      # settings.globalOptions = {
      #   pinyin.globalSection.EmojiEnabled = "True";
      # };

      # settings.inputMethod = {};
    };

    home.file."/.local/share/fcitx5/rime/default.custom.yaml" = {
      enable = true;
      source = ../config/rime-custom/my-key-bindings.yaml;
    };
  };
}
