{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nvchad4nix.homeManagerModule
  ];
  myHomeManager.spotify.enable = true;
  myHomeManager.zellij.enable = true;
  myHomeManager.nvchad.enable = true;

  home.packages = with pkgs; [
    lazygit
    inputs.agenix.packages.${pkgs.system}.default
  ];
}
