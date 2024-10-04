{pkgs, ...}: let
  nvim-plugintree = pkgs.vimPlugins.nvim-treesitter.withPlugins (p:
    with p; [
      bash
      javascript
      json
      lua
      markdown
      nix
      python
      regex
      rust
      typescript
      yaml
    ]);
  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = nvim-plugintree.dependencies;
  };
in {
  programs.nixvim.plugins.lazy.plugins = [
    {
      pkg = pkgs.vimPlugins.nvim-treesitter;
      event = ["BufReadPost" "BufNewFile"];
      cmd = ["TSInstall" "TSBufEnable" "TSBufDisable" "TSModuleInfo"];
      opts = {
        highlight = {
          enable = true;
          use_languagetree = true;
        };
        indent.enable = true;
      };
      config = ''
        function(_, opts)
          vim.opt.runtimepath:append("${nvim-plugintree}")
          vim.opt.runtimepath:append("${treesitter-parsers}")
          require("nvim-treesitter.configs").setup(opts)
        end
      '';
    }
  ];
}
