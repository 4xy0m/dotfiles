{
  pkgs,
  ...
}: {
  imports = [./powermenu/default.nix];
  home.packages = [
    pkgs.rofi
  ];
}
