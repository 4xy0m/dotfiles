{
  inputs,
  pkgs,
  ...
}: {
  imports = [
  ];
  myHomeManager.spotify.enable = true;
  myHomeManager.zellij.enable = true;

  home.packages = with pkgs; [
    lazygit
    inputs.agenix.packages.${pkgs.system}.default
  ];
}
