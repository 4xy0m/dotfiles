{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types;
in rec {
  options.myHomeManager.cursor = mkOption {
    type = types.submodule {
      options = {
        size = mkOption {
          type = types.int;
        };
        name = mkOption {
          type = types.str;
        };
        package = mkOption {
          type = types.package;
        };
      };
    };
  };
}
