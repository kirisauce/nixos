{ pkgs, lib, ... }:

{
  fonts.fontconfig.enable = true;

  fonts.packages = with pkgs; [
    cascadia-code
    maple-mono.NF-CN
    nerd-fonts.fantasque-sans-mono
    lxgw-wenkai
    noto-fonts-color-emoji
  ];

  fonts.fontconfig.defaultFonts = {
    emoji = [
      "Noto Color Emoji"
    ];

    serif = [
      "LXGW WenKai"
    ];

    sansSerif = [
      "LXGW WenKai"
    ];

    monospace = [
      "Maple Mono NF CN"
    ];
  };
}
