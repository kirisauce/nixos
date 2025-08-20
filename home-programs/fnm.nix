{ pkgs, lib, config, ... }:

{
  options.myConfig.fnm = {
    enable = lib.mkEnableOption "fnm";

    zsh-integration = lib.mkEnableOption "zsh integration for fnm";
  };

  config = lib.mkIf config.myConfig.fnm.enable (with config.myConfig.fnm; {
    home.packages = [ pkgs.fnm ];

    programs.zsh.initContent = lib.optionals zsh-integration ''
      eval "$(fnm env --use-on-cd --shell zsh)"

      export fpath=($fpath ${toString ((lib.getBin pkgs.fnm) + /share/zsh/site-functions)})
    '';
  });
}
