{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = [
    {
      pkg = pkgs.vimPlugins.vim-bbye;
      cmd = ["Bdelete"];
    }
  ];
}
