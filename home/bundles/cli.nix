{pkgs, ...}: {
  myHomeManager.zsh.enable = true;
  myHomeManager.starship.enable = true;

  home.packages = with pkgs; [
    ripgrep
    git
    gh
    fzf
  ];
}
