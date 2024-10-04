{
  pkgs,
  config,
  lib,
  ...
}: {
  options.myHomeManager.rofi.powermenu = {
    font = lib.mkOption {
      type = lib.types.str;
    };
    box-margin = lib.mkOption {
      type = lib.types.str;
    };
    element-padding = lib.mkOption {
      type = lib.types.str;
    };
    element-font = lib.mkOption {
      type = lib.types.str;
    };
  };
  config = {
    home.packages = [
      (pkgs.writeShellScriptBin "powermenu" (builtins.readFile ./powermenu.sh))
    ];

    xdg.configFile."rofi/powermenu/config.rasi".text = with config.colorScheme.palette;
    with config.myHomeManager.rofi.powermenu; ''
      * {
        background-transparent:     #${base01 + "CC"};
        background:                 #${base01 + "CC"};
        background-alt:             #${base00 + "FF"};
        foreground:                 #${base05 + "FF"};
        selected:                   #${base07 + "FF"};
        active:                     #${base0B + "FF"};
        urgent:                     #${base08 + "FF"};
        font:                       "${font}";
        box-margin:                 ${box-margin};
        element-padding:            ${element-padding};
        element-font:               "${element-font}";
      }
    '';
    xdg.configFile."rofi/powermenu/confirm.rasi".source = ./confirm.rasi;
    xdg.configFile."rofi/powermenu/powermenu.rasi".source = ./powermenu.rasi;
  };
}
