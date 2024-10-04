{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
  myHomeManager.nixvim.enable = true;
  myHomeManager.spotify.enable = true;
  myHomeManager.zellij.enable = true;

  home.packages = with pkgs; [
    lazygit
    inputs.agenix.packages.${pkgs.system}.default
  ];
}
