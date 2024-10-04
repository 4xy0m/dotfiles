{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = [
    {
      pkg = pkgs.vimPlugins.nvim-autopairs;
      event = "InsertEnter";
      config = true;
    }
  ];
}
