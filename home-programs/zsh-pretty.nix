{ config, lib, pkgs, ... }:

{
  options.myConfig.zshPretty = with lib; {
    enable = mkEnableOption "pretty zsh";
    extraInit.enable = mkOption {
      description = "Whether to execute the extra init file when init. ($HOME/.zshrc-extra)";
      default = true;
      type = types.bool;
    };
  };

  config = with config.myConfig.zshPretty; lib.mkIf enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;

      autosuggestion.enable = true;
      autosuggestion.strategy = [ "history" "completion" ];

      initContent =
        (builtins.readFile ../config/zsh-pretty.zsh) +
	(if extraInit.enable then "\nsource \"$HOME/.zshrc-extra\"" else "") +
	''
	autoload -U compinit
	compinit -d
	'';
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;

      options = [ "--cmd=cd" ];
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.eza = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
