{
  pkgs,
  ...
}: {
  myHomeManager.spotify.enable = true;
  myHomeManager.zellij.enable = true;
  myHomeManager.nvchad.enable = true;
  myHomeManager.yazi.enable = true;
  myHomeManager.termfilepickers.enable = false;

  home.packages = with pkgs; [
    lazygit
    gh-dash
    impala
  ];
}
