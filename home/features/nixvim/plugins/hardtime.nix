{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = [
    {
      pkg = pkgs.vimPlugins.hardtime-nvim;
      dependencies = [pkgs.vimPlugins.nui-nvim pkgs.vimPlugins.plenary-nvim];
    }
  ];
}
