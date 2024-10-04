{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = [
    {
      pkg = pkgs.vimPlugins.bufferline-nvim;
      dependencies = [pkgs.vimPlugins.nvim-web-devicons];
      opts.options = {
        offsets = [
          {
            filetype = "NvimTree";
            text = "";
            highlight = "NvimTreeNormal";
            text_align = "left";
            separator = false;
          }
        ];
      };
    }
  ];
}
