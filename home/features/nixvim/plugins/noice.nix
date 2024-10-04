{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = [
    {
      pkg = pkgs.vimPlugins.noice-nvim;
      dependencies = [pkgs.vimPlugins.nui-nvim];
      config = true;
      opts.views.mini.win_options.winblend = 0;
    }
  ];
}
