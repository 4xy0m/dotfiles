{
  pkgs,
  ...
}: {
  imports = [./powermenu/default.nix ./launcher/default.nix];
  home.packages = [
    pkgs.rofi
  ];
}
