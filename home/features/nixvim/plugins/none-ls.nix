{pkgs, ...}: {
  programs.nixvim.extraPackages = with pkgs; [
    # web dev
    nodePackages_latest.eslint_d
    prettierd
    # sql
    sqlfluff
    # lua
    stylua
    selene
    # nix
    statix
    alejandra
  ];
  programs.nixvim.plugins.lazy.plugins = [
    {
      pkg = pkgs.vimPlugins.none-ls-nvim;
      dependencies = [
        (pkgs.vimUtils.buildVimPlugin
          {
            name = "none-ls-extras-nvim";
            src = pkgs.fetchFromGitHub {
              owner = "nvimtools";
              repo = "none-ls-extras.nvim";
              rev = "336e84b9e43c0effb735b08798ffac382920053b";
              hash = "sha256-UtU4oWSRTKdEoMz3w8Pk95sROuo3LEwxSDAm169wxwk=";
            };
          })
      ];
      config =
        # lua
        ''
          function()
          	local null_ls = require("null-ls")
          	null_ls.setup({
          		sources = {
          			-- lua
          			null_ls.builtins.formatting.stylua,
          			null_ls.builtins.diagnostics.selene,

          			--nix
          			null_ls.builtins.formatting.alejandra,
          			null_ls.builtins.diagnostics.statix,

          			--web-dev
          			null_ls.builtins.formatting.prettierd,
          			require("none-ls.diagnostics.eslint_d"),

          			-- sql
          			null_ls.builtins.formatting.sqlfluff.with({
          				extra_args = { "--dialect", "postgres" }, -- change to your dialect
          			}),
          			null_ls.builtins.diagnostics.sqlfluff.with({
          				extra_args = { "--dialect", "postgres" }, -- change to your dialect
          			}),
          		},
          	})
          end
        '';
    }
  ];
}
