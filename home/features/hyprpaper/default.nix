{config, ...}: {
  imports = [./wallpaper.nix];

  xdg.configFile."wallpapers/" = {
    source = ./wallpapers;
    recursive = true;
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = ["~/.config/wallpapers/${config.myHomeManager.wallpaper}"];
      wallpaper = [", ~/.config/wallpapers/${config.myHomeManager.wallpaper}"];
    };
  };
}
