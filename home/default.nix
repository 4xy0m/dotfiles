{
  myLib,
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.myHomeManager;
  features =
    myLib.extendModules
    (name: {
      extraOptions = {
        myHomeManager.${name}.enable = lib.mkEnableOption "enable my ${name} configuration";
      };

      configExtension = config: (lib.mkIf cfg.${name}.enable config);
    })
    (myLib.filesIn ./features);
  bundles =
    myLib.extendModules
    (name: {
      extraOptions = {
        myHomeManager.bundles.${name}.enable = lib.mkEnableOption "enable ${name} bundles";
      };

      configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
    })
    (myLib.filesIn ./bundles);
in {
  imports =
    []
    ++ features
    ++ bundles;
}
