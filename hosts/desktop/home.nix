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
  myHomeManager.bundles.dev.enable = true;

  myHomeManager.wallpaper = "abstract-swirls.jpg";

  myHomeManager.cursor = {
    name = "Bibata-Modern-Classic";
    size = 16;
    package = pkgs.bibata-cursors;
  };

  myHomeManager.monitors = [
    {
      name = "DP-2";
      width = 3440;
      height = 1440;
      refreshRate = 144.0;
      x = 1080;
      y = 0;
      enabled = true;
    }
    {
      name = "HDMI-A-1";
      width = 1920;
      height = 1080;
      refreshRate = 75.0;
      x = 0;
      y = 0;
      rotating = 1;
      enabled = true;
    }
  ];

  myHomeManager.rofi = {
    launcher = {
      font = "JetBrainsMono Nerd Font 12";
      width = 700;
    };
    powermenu = {
      box-margin = "531px 1070px";
      element-padding = "88px 0px";
      element-font = "feather 33";
      font = "JetBrainsMono Nerd Font 11";
    };
  };

  home.stateVersion = "24.05";

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  programs.home-manager.enable = true;
}
