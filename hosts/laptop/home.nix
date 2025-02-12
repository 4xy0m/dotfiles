{
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports = [
    outputs.homeManagerModules.default
    inputs.nix-colors.homeManagerModules.default
  ];

  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  myHomeManager.bundles.tui.enable = true;
  myHomeManager.bundles.gui.enable = true;
  myHomeManager.bundles.cli.enable = true;
  myHomeManager.bundles.hypr.enable = true;

  myHomeManager.wallpaper = "abstract-swirls.jpg";

  myHomeManager.cursor = {
    name = "Bibata-Modern-Classic";
    size = 16;
    package = pkgs.bibata-cursors;
  };

  myHomeManager.monitors = [
    {
      name = "eDP-1";
      width = 1920;
      height = 1200;
      refreshRate = 60.0;
      x = 0;
      y = 0;
      enabled = true;
      scale = 1.25;
    }
  ];

  myHomeManager.rofi = {
    launcher = {
      font = "JetBrainsMono Nerd Font 10";
      width = 600;
    };
    powermenu = {
      box-margin = "325px 300px";
      element-padding = "62px 0px";
      element-font = "feather 25";
      font = "JetBrainsMono Nerd Font 9.5";
    };
  };

  home.stateVersion = "24.05";

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  programs.home-manager.enable = true;
}
