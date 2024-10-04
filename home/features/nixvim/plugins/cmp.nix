{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins.lazy.plugins = let
    options = {
      completion = {
        completeopt = "menu,menuone";
      };

      window = {
        completion = {
          winhighlight = "FloatBorder:CmpBorder,Normal:Pmenu,CursorLine:PmenuSel,Search:PmenuSel";
          scrollbar = false;
          sidePadding = 0;
          border = ["╭" "─" "╮" "│" "╯" "─" "╰" "│"];
        };
      };

      snippet = {
        expand.__raw = ''
          function(args)
            require('luasnip').lsp_expand(args.body)
          end
        '';
      };

      sources = [
        {name = "nvim_lsp";}
        {name = "luasnip";}
        {name = "buffer";}
        {name = "nvim_lua";}
        {name = "path";}
      ];

      formatting = {
        fields = ["abbr" "kind" "menu"];
        format.__raw =
          # lua
          ''
            function(_, item)
              local icons = {
                Namespace = "󰌗",
                Text = "󰉿",
                Method = "󰆧",
                Function = "󰆧",
                Constructor = "",
                Field = "󰜢",
                Variable = "󰀫",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "󰑭",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈚",
                Reference = "󰈇",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "󰙅",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "󰊄",
                Table = "",
                Object = "󰅩",
                Tag = "",
                Array = "[]",
                Boolean = "",
                Number = "",
                Null = "󰟢",
                String = "󰉿",
                Calendar = "",
                Watch = "󰥔",
                Package = "",
                Copilot = "",
                Codeium = "",
                TabNine = "",
              }

              local icon = icons[item.kind] or ""
              item.kind = string.format("%s %s", icon, item.kind or "")
              return item
            end
          '';
      };

      mapping = {
        "<CR>".__raw = ''cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })'';
        "<S-Tab>".__raw = ''cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})'';
        "<Tab>".__raw = ''cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})'';
      };
    };
  in [
    {
      pkg = pkgs.vimPlugins.nvim-cmp;
      dependencies = [
        pkgs.vimPlugins.nvim-lspconfig
        pkgs.vimPlugins.cmp-nvim-lsp
        pkgs.vimPlugins.cmp_luasnip
        pkgs.vimPlugins.cmp-buffer
        pkgs.vimPlugins.cmp-nvim-lua
        pkgs.vimPlugins.cmp-path
        {
          pkg = pkgs.vimPlugins.luasnip;
          dependencies = [pkgs.vimPlugins.friendly-snippets];
          config = ''
            function()
              require("luasnip").config.set_config({})
              require("luasnip.loaders.from_vscode").lazy_load({ paths = "${pkgs.vimPlugins.friendly-snippets}" })
            end
          '';
        }
      ];
      lazy = false;
      config = ''
        function()
            local cmp = require("cmp")
        	cmp.setup(${config.nixvim.helpers.toLuaObject options})
        end
      '';
    }
  ];
}
