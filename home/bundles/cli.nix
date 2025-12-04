{ pkgs, ... }:
{
  myHomeManager.zsh.enable = true;
  myHomeManager.starship.enable = true;
  myHomeManager.cava.enable = true;

  home.packages = with pkgs; [
    ripgrep
    git
    gh
    fzf
    playerctl
    fastfetch
    zip
    unzip
    github-copilot-cli
  ];
}
