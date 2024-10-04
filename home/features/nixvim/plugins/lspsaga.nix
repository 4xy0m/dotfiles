{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = [
    {
      pkg = pkgs.vimPlugins.lspsaga-nvim;
      dependencies = [pkgs.vimPlugins.nvim-web-devicons pkgs.vimPlugins.nvim-treesitter];
      config = true;
      opts = {
        implement.enable = false;
        symbol_in_winbar.enable = false;
      };
    }
  ];
}
