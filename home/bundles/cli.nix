{ pkgs, inputs, ... }:
{
  myHomeManager.zsh.enable = true;
  myHomeManager.starship.enable = true;
  myHomeManager.cava.enable = true;
  myHomeManager.direnv.enable = true;
  myHomeManager.opencode.enable = true;

  home.packages = with pkgs; [
    ripgrep
    git
    gh
    fzf
    playerctl
    fastfetch
    zip
    unzip
  ];
}
