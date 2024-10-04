{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = [
    {
      pkg = pkgs.vimPlugins.nvim-colorizer-lua;
      config = true;
    }
  ];
}
