{
  config,
  pkgs,
  ...
}: {
  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-lavender-compact+rimless";
      package = pkgs.catppuccin-gtk.override {
        accents = ["lavender"];
        size = "compact";
        tweaks = ["rimless"];
        variant = "mocha";
      };
    };
    cursorTheme = {
      name = config.myHomeManager.cursor.name;
      package = config.myHomeManager.cursor.package;
      size = config.myHomeManager.cursor.size;
    };
  };
}
