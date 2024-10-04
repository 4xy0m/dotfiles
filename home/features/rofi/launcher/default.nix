{
  pkgs,
  config,
  lib,
  ...
}: {
  options.myHomeManager.rofi.launcher = {
    width = lib.mkOption {
      type = lib.types.int;
    };
    font = lib.mkOption {
      type = lib.types.str;
    };
  };
  config = {
    home.packages = [
      (pkgs.writeShellScriptBin "launcher" (builtins.readFile ./launcher.sh))
    ];

    xdg.configFile."rofi/launcher/config.rasi".text = with config.colorScheme.palette;
    with config.myHomeManager.rofi.launcher; ''
      * {
        background:     #${base01 + "FF"};
        background-alt: #${base00 + "FF"};
        foreground:     #${base05 + "FF"};
        selected:       #${base07 + "FF"};
        active:         #${base0B + "FF"};
        urgent:         #${base08 + "FF"};
        font:           "${font}";
        width:          ${builtins.toString width}px;
      }
    '';
    xdg.configFile."rofi/launcher/launcher.rasi".source = ./launcher.rasi;
  };
}
