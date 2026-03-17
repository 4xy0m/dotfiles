{ pkgs, inputs, ... }: {
  myHomeManager.ghostty.enable = true;
  myHomeManager.hyprland.enable = true;
  myHomeManager.hyprlock.enable = true;
  myHomeManager.hypridle.enable = true;
  myHomeManager.noctalia.enable = true;

  home.packages = with pkgs; [
    material-icons
    nerd-fonts.jetbrains-mono
    lucide
    newcomputermodern
    inputs.HyprQuickFrame.packages.${pkgs.system}.default
  ];
}
