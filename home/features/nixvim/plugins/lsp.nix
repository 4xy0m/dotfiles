{pkgs, ...}: {
  programs.nixvim.extraPackages = with pkgs; [
    nixd
    ruff-lsp
    lua-language-server
    rust-analyzer
    nodePackages.graphql-language-service-cli
    nodePackages.svelte-language-server
    nodePackages.typescript-language-server
    taplo
  ];
  programs.nixvim.plugins.lazy.plugins = [
    {
      pkg = pkgs.vimPlugins.nvim-lspconfig;
      dependencies = [pkgs.vimPlugins.cmp-nvim-lsp];
      config =
        # lua
        ''
                  function(_, opts)
                  	local lsp = require("lspconfig")
          local capabilities = require("cmp_nvim_lsp").default_capabilities()
                  	for _, server in ipairs(opts.servers) do
                  		lsp[server.name].setup({capabilities = capabilities})
                  	end
                  	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                    		vim.lsp.diagnostic.on_publish_diagnostics, {
                      			update_in_insert = true,
           		}
                  	)
                  end
        '';
      opts = {
        servers = [
          {name = "nixd";}
          {name = "ruff_lsp";}
          {name = "lua_ls";}
          {name = "rust_analyzer";}
          {name = "graphql";}
          {name = "svelte";}
          {name = "tsserver";}
          {name = "taplo";}
        ];
      };
    }
  ];
}
