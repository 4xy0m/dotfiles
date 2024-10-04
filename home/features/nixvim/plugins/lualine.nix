{
  config,
  pkgs,
  ...
}: {
  programs.nixvim.plugins.lazy.plugins = with config.colorScheme.palette; [
    {
      pkg = pkgs.vimPlugins.lualine-nvim;
      dependencies = [pkgs.vimPlugins.nvim-web-devicons];
      opts = {
        options = {
          globalstatus = true;
          theme = "catppuccin";
          icons_enabled = true;
        };
        sections = {
          lualine_a = [
            (config.nixvim.helpers.listToUnkeyedAttrs ["mode"]
              // {
                color.gui = "bold";
                separator.right = "";
                fmt.__raw =
                  # lua
                  ''
                    function(str)
                              return " " .. str
                    end
                  '';
              })
            (config.nixvim.helpers.listToUnkeyedAttrs [""]
              // {
                draw_empty = true;
                padding = {
                  left = 0;
                  right = 0;
                };
                color = "LuaLineEmptySpace";
                separator.right = "";
              })
          ];
          lualine_b = [
            (config.nixvim.helpers.listToUnkeyedAttrs ["filetype"]
              // {
                icon_only = true;
                colored = false;
                color = "LuaLineFile";
                separator = "";
                padding = {
                  right = 0;
                  left = 1;
                };
              })
            (config.nixvim.helpers.listToUnkeyedAttrs ["filename"]
              // {
                color = "LuaLineFile";
                separator.right = "";
                padding = {
                  right = 1;
                  left = 0;
                };
              })
          ];
          lualine_c = [
            (config.nixvim.helpers.listToUnkeyedAttrs ["branch"]
              // {
                icon = "";
                color = "LuaLineBranch";
              })
            (config.nixvim.helpers.listToUnkeyedAttrs ["diff"]
              // {
                colored = false;
                color = "LuaLineDiff";
                symbols = {
                  added = "  ";
                  modified = "  ";
                  removed = "  ";
                };
              })
          ];
          lualine_x = [
            (config.nixvim.helpers.listToUnkeyedAttrs ["diagnostics"]
              // {
                symbols = {
                  error = " ";
                  warn = " ";
                };
              })
            (config.nixvim.helpers.listToUnkeyedAttrs [
                (config.nixvim.helpers.mkRaw
                  # lua
                  ''
                    function()
                    	local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                    	local clients = vim.lsp.get_active_clients()
                    	if next(clients) == nil then
                    			return ""
                    	end

                    	local msg = ""
                    	for _, client in ipairs(clients) do
                    			local filetypes = client.config.filetypes
                    			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= "null-ls" then
                    					msg = msg .. client.name .. " "
                    			end
                    	end

                    	if msg then
                    		return "  LSP ~ " .. msg
                    	else
                    		return ""
                    	end
                    end
                  '')
              ]
              // {
                color = "LuaLineLsp";
              })
          ];
          lualine_y = [
            (config.nixvim.helpers.listToUnkeyedAttrs ["'󰉋 '"]
              // {
                padding = {
                  left = 0;
                  right = 0;
                };
                separator = {left = "";};
                color = "LuaLineCwdIcon";
              })
            (config.nixvim.helpers.listToUnkeyedAttrs [''(vim.loop.cwd():match "([^/\\]+)[/\\]*$" or name)'']
              // {
                color = "LuaLineCwd";
              })
          ];
          lualine_z = [
            (config.nixvim.helpers.listToUnkeyedAttrs ["' '"]
              // {
                separator = {left = "";};
                color = "LuaLinePositionIcon";
                padding = {
                  left = 0;
                  right = 0;
                };
              })
            (config.nixvim.helpers.listToUnkeyedAttrs ["progress"]
              // {
                color = "LuaLinePosition";
              })
          ];
        };
      };
    }
  ];
}
