{ pkgs, inputs, ... }: {
  myHomeManager.ghostty.enable = true;
  myHomeManager.hyprland.enable = true;
  myHomeManager.waybar.enable = true;
  myHomeManager.hyprlock.enable = true;
  myHomeManager.hyprpaper.enable = true;
  myHomeManager.hypridle.enable = true;
  myHomeManager.vicinae.enable = true;
  myHomeManager.rofi.enable = true;
  myHomeManager.dunst.enable = true;

  home.packages = with pkgs; [
    material-icons
    (callPackage ../../pkgs/icomoon-feather/default.nix { })
    nerd-fonts.jetbrains-mono
    lucide
    newcomputermodern
    inputs.HyprQuickFrame.packages.${pkgs.system}.default
  ];
}
