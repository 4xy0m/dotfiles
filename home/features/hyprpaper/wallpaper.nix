{lib, ...}: {
  options = {
    myHomeManager.wallpaper = lib.mkOption {
      type = lib.types.string;
      description = ''
        Path to yout wallpaper
      '';
    };
  };
}
