{ inputs, lib, pkgs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    inputs.nxchad.homeManagerModules.nixvim
  ];
  programs.zsh.shellAliases.nv = "nvim";
  programs.nixvim = {
    enable = true;
    nxchad.config.base46 = {
      theme = "catppuccin";
      transparency = true;
    };
    diagnostic.settings = {
      virtual_lines = { current_line = true; };
      virtual_text = true;
      update_in_insert = false;
      underline = true;
    };
    opts = {
      number = true;
      relativenumber = true;
      conceallevel = 1;
    };
    extraPlugins = with pkgs.vimPlugins; [ multicursor-nvim ];
    extraConfigLua = ''
            local result = os.execute("env -u TMPDIR /bin/sh -c 'ya emit-to $(expr $ZELLIJ_PANE_ID - 1) ping'")

            if result == 0 then
              vim.api.nvim_create_autocmd('BufEnter', {
                callback = function()
                  local buftype = vim.api.nvim_buf_get_option(0, "buftype")
                  if buftype ~= "" then return end

                  local filename = vim.api.nvim_buf_get_name(0)
                  if filename == "" then return end
                  os.execute(string.format(
                    "env -u TMPDIR /bin/sh -c 'ya emit-to $(expr $ZELLIJ_PANE_ID - 1) reveal \"%s\" >/dev/null 2>&1'", filename))
                end,
              })
            end

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'DiagnosticChanged' }, {
           group = vim.api.nvim_create_augroup('diagnostic_virt_text_hide', {}),
        callback = function(ev)
          local lnum, _ = unpack(vim.api.nvim_win_get_cursor(0))
          lnum = lnum - 1 -- need 0-based index

         local hidden_lnum = vim.b[ev.buf].diagnostic_hidden_lnum
         if hidden_lnum and hidden_lnum ~= lnum then
           vim.b[ev.buf].diagnostic_hidden_lnum = nil
           -- display all the decorations if the current line changed
           vim.diagnostic.show(nil, ev.buf)
         end

         for _, namespace in pairs(vim.diagnostic.get_namespaces()) do
           local ns_id = namespace.user_data.virt_text_ns
             if ns_id then
               local extmarks = vim.api.nvim_buf_get_extmarks(ev.buf, ns_id, { lnum, 0 }, { lnum, -1 }, {})
               for _, extmark in pairs(extmarks) do
                 local id = extmark[1]
                 vim.api.nvim_buf_del_extmark(ev.buf, ns_id, id)
               end

               if extmarks and not vim.b[ev.buf].diagnostic_hidden_lnum then
                 vim.b[ev.buf].diagnostic_hidden_lnum = lnum
              end
            end
          end
        end,
      })

            vim.api.nvim_create_autocmd('ModeChanged', {
              group = vim.api.nvim_create_augroup('diagnostic_redraw', {}),
              callback = function()
                pcall(vim.diagnostic.show)
              end
            })

              local mc = require("multicursor-nvim")
              mc.setup()

              local set = vim.keymap.set

              -- Add cursors up/down with Ctrl-Up / Ctrl-Down
              set({"n", "x"}, "<C-S-Up>", function() mc.lineAddCursor(-1) end)
              set({"n", "x"}, "<C-S-Down>", function() mc.lineAddCursor(1) end)

              -- Match next/prev with Alt-Up / Alt-Down (no C-p/n conflict)
              set({"n", "x"}, "<M-Down>", function() mc.matchAddCursor(1) end)
              set({"n", "x"}, "<M-Up>", function() mc.matchAddCursor(-1) end)

              -- Skip matches with Alt-Right / Alt-Left
              set({"n", "x"}, "<M-Right>", function() mc.matchSkipCursor(1) end)
              set({"n", "x"}, "<M-Left>", function() mc.matchSkipCursor(-1) end)

              -- Toggle multicursor mode
              set({"n", "x"}, "<M-a>", mc.matchAllAddCursors)
              set({"n", "x"}, "<C-q>", mc.toggleCursor)

              -- Mouse support
              set("n", "<C-LeftMouse>", mc.handleMouse)
              set("n", "<C-LeftDrag>", mc.handleMouseDrag)
              set("n", "<C-LeftRelease>", mc.handleMouseRelease)

              -- Keymap layer for multicursor mode
              mc.addKeymapLayer(function(layerSet)
                  -- Move between cursors using ← → keys
                  -- layerSet({"n", "x"}, "<Left>", mc.prevCursor)
                  -- layerSet({"n", "x"}, "<Right>", mc.nextCursor)

                  -- Delete current cursor with `Del`
                  layerSet({"n", "x"}, "<Del>", mc.deleteCursor)

                  -- Esc to enable or clear cursors
                  layerSet("n", "<Esc>", function()
                      if not mc.cursorsEnabled() then
                          mc.enableCursors()
                      else
                          mc.clearCursors()
                      end
                  end)
              end)      

              -- Customize how cursors look.
              local hl = vim.api.nvim_set_hl
              hl(0, "MultiCursorCursor", { reverse = true })
              hl(0, "MultiCursorVisual", { link = "Visual" })
              hl(0, "MultiCursorSign", { link = "SignColumn"})
              hl(0, "MultiCursorMatchPreview", { link = "Search" })
              hl(0, "MultiCursorDisabledCursor", { reverse = true })
              hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
              hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})

          -- Credit: https://github.com/swaits/zellij-nav.nvim
          local function nav(short_direction, direction, action, resize, close_after)
            -- Use "move-focus" if action is nil.
            if not action then
              action = "move-focus"
            end

            if action ~= "move-focus" and action ~= "move-focus-or-tab" then
              error("invalid action: " .. action)
            end

            -- get window ID, try switching windows, and get ID again to see if it worked
            local cur_winnr = vim.fn.winnr()
            vim.api.nvim_command("wincmd " .. short_direction)
            local new_winnr = vim.fn.winnr()

            -- if the window ID didn't change, then we didn't switch
            if cur_winnr == new_winnr then
              -- if resize then decrease current pane
              if resize then
                vim.fn.system("zellij action resize decrease")
                if close_after then
                  vim.api.nvim_create_autocmd("FocusGained", {
                    pattern = "*",
                    once = true,
                    callback = function()
                      os.execute("zellij action resize increase")
                    end
                  })
                end
              end
              vim.fn.system("zellij action " .. action .. " " .. direction)
              if vim.v.shell_error ~= 0 then
                error("zellij executable not found in path")
              end
            end
          end

          local map = vim.keymap.set

          map("n", "<c-left>", function() nav("h", "left", "move-focus-or-tab", false, false) end)
          map("n", "<c-down>", function() nav("j", "down", nil, true, true) end)
          map("n", "<c-up>", function() nav("k", "up", nil, false, false) end)
          map("n", "<c-right>", function() nav("l", "right", "move-focus-or-tab", false, false) end)
    '';
    keymaps = [
      {
        action = "<cmd>lua require('flash').jump()<cr>";
        key = "s";
        mode = [ "n" "x" "o" ];
      }
      {
        action = "<C-d>zz";
        key = "<C-d>";
        mode = [ "n" ];
      }
      {
        action = "<C-u>zz";
        key = "<C-u>";
        mode = [ "n" ];
      }
      {
        action.__raw = ''
          function()
            os.execute("zellij run -d right -- copilot")
            os.execute("zellij action resize decrease")
          end
        '';
        key = "<C-a>";
        mode = [ "n" ];
      }
    ];
    autoCmd = [
      {
        event = [ "VimLeave" ];
        pattern = "*";
        command = "silent !zellij action switch-mode normal";
      }
      {
        event = [ "VimEnter" ];
        pattern = "*";
        command = "silent !zellij action resize increase";
      }
      {
        event = [ "VimResized" ];
        pattern = "*";
        command = "wincmd =";
      }
    ];
    lsp = {
      servers = {
        svelte.enable = true;
        ruff.enable = true;
        nixd.enable = true;
        eslint.enable = true;
        ts_ls.enable = true;
        jdtls.enable = true;
        tinymist = {
          enable = true;
          config.settings.formatterMode = "typstyle";
        };
        ty.enable = true;
        rust_analyzer = {
          enable = true;
          settings = { cargo.features = "all"; };
        };
      };
    };
    plugins = {
      obsidian = {
        enable = true;
        lazyLoad.enable = true;
        lazyLoad.settings.event = "InsertEnter";
        settings = {
          legacy_commands = false;
          completion = {
            nvim_cmp = false;
            blink = true;
          };
          workspaces = [{
            name = "notes";
            path = "~/notes/";
          }];
          templates.folder = "templates";
        };
      };
      treesitter.settings.ensure_installed = lib.mkForce [];
      treesitter.grammarPackages =
        with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          json
          lua
          make
          markdown
          nix
          regex
          toml
          vim
          vimdoc
          xml
          yaml
          rust
          python
          toml
        ];
      markdown-preview.enable = true;
      typst-preview.enable = true;
      nvim-tree.enable = lib.mkForce false;
      zellij-nav.enable = true;
      flash.enable = true;
      nvim-surround.enable = true;
      noice = {
        enable = true;
        settings.lsp = {
          hover.enabled = false;
          signature.enabled = false;
        };
      };
      none-ls = {
        enable = true;
        sources = {
          formatting = {
            nixfmt.enable = true;
            prettier.enable = true;
            djlint.enable = true;
          };
          diagnostics = { djlint.enable = true; };
        };
      };
    };
  };
}
