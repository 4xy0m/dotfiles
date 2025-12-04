{lib, ...}: {
  options = {
    myHomeManager.wallpaper = lib.mkOption {
      type = lib.types.str;
      description = ''
        Path to yout wallpaper
      '';
    };
  };
}
