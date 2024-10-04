{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = [
    {
      pkg = pkgs.vimPlugins.which-key-nvim;
      keys = ["<leader>"];
      cmd = "WhichKey";
      config = ''
        function()
        	require("which-key").setup()
        end
      '';
    }
  ];
}
