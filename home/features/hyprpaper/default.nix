{ config, ... }: {
  imports = [ ./wallpaper.nix ];

  xdg.configFile."wallpapers/" = {
    source = ./wallpapers;
    recursive = true;
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      wallpaper = [{
        monitor = "";
        path = [ "~/.config/wallpapers/${config.myHomeManager.wallpaper}" ];
      }];
    };
  };
}
