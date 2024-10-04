{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = [
    {
      pkg = pkgs.vimPlugins.catppuccin-nvim;
      priority = 1000;
      name = "catppuccin";
      config =
        # lua
        ''
          function(_, opts)
          	require("catppuccin").setup(opts)
          	vim.cmd.colorscheme("catppuccin")
          end
        '';
      opts = {
        custom_highlights.__raw =
          # lua
          ''
            function(colors)
            	return {
            		Normal = { bg = colors.none },
            		NormalFloat = { bg = colors.none },
            		NormalNC = { bg = colors.none },
            		CmpBorder = { fg = colors.surface2 },
            		Pmenu = { bg = colors.none },
            		LuaLineFile = { bg = colors.surface0, fg = colors.text },
            		LuaLineBranch = { bg = colors.mantle, fg = colors.overlay0 },
            		LuaLineDiff = { bg = colors.mantle, fg = colors.overlay0 },
            		LuaLineEmptySpace = { bg = colors.surface1 },
            		LuaLineLsp = { bg = colors.mantle, fg = colors.blue },
            		LuaLinePosition = { bg = colors.surface0, fg = colors.green },
            		LuaLinePositionIcon = { bg = colors.green, fg = colors.mantle },
            		LuaLineCwd = { bg = colors.surface0, fg = colors.text },
            		LuaLineCwdIcon = { bg = colors.red, fg = colors.mantle },
            		NvimTreeIndentMarker = { fg = colors.surface1 },
            	}
            end
          '';
        flavour = "mocha";
        term_colors = true;
        integrations = {
          telescope = {
            enabled = true;
            style = "nvchad";
          };
          alpha = true;
          cmp = true;
          gitsigns = true;
          indent_blankline = true;
          nvimtree = true;
          treesitter = true;
          which_key = true;
          lsp_saga = true;
          leap = true;
        };
      };
    }
  ];
}
