{ config, lib, pkgs, ... }:

let
  inherit (lib) types;
in
{
  options.gsettings-schemas = {
    enable = lib.mkEnableOption "gsettings schemas environment";
    packages = lib.mkOption {
      type = types.listOf types.path;
      description = "Packages that needs to exposure their gsettings schemas";
      default = [];
    };
  };

  config.environment.extraInit = lib.optionals config.gsettings-schemas.enable (let
      toSchemaDataDirPath = pkg: pkgs.glib.getSchemaDataDirPath (lib.getLib pkg);
      paths = builtins.concatStringsSep ":" (map toSchemaDataDirPath config.gsettings-schemas.packages);
      varName = "XDG_DATA_DIRS";
    in
    ''
      if [ -z "${"$" + varName}" ]; then
        export ${varName}='${paths}'
      else
        export ${varName}="${"$" + varName}:"'${paths}'
      fi
    ''
  );
}
