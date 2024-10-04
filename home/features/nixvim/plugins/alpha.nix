{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = [
    {
      pkg = pkgs.vimPlugins.alpha-nvim;
      opts = {
        layout = [
          {
            type = "padding";
            val = 10;
          }
          {
            type = "text";
            val = [
              "                                                                     "
              "       ████ ██████           █████      ██                     "
              "      ███████████             █████                             "
              "      █████████ ███████████████████ ███   ███████████   "
              "     █████████  ███    █████████████ █████ ██████████████   "
              "    █████████ ██████████ █████████ █████ █████ ████ █████   "
              "  ███████████ ███    ███ █████████ █████ █████ ████ █████  "
              " ██████  █████████████████████ ████ █████ █████ ████ ██████ "
            ];
            opts = {
              position = "center";
              hl = "AlphaHeader";
            };
          }
          {
            type = "padding";
            val = 2;
          }
          {
            type = "group";
            opts.spacing = 1;
            val = let
              mkButton = shortcut: cmd: val: {
                type = "button";
                inherit val;
                opts = {
                  inherit shortcut;
                  hl = "AlphaButton";
                  keymap = [
                    "n"
                    shortcut
                    cmd
                    {}
                  ];
                  position = "center";
                  cursor = 0;
                  width = 40;
                  align_shortcut = "right";
                  hl_shortcut = "Keyword";
                };
              };
            in [
              (
                mkButton
                "f"
                "<CMD>lua require('telescope.builtin').find_files({hidden = true})<CR>"
                "  Find File"
              )
              (
                mkButton
                "o"
                "<CMD>lua require('telescope.builtin').oldfiles({hidden = true})<CR>"
                "󰈚  Recent Files"
              )
              (
                mkButton
                "g"
                "<CMD>lua require('telescope.builtin').live_grep({hidden = true})<CR>"
                "󰈭  Find Word"
              )
              (
                mkButton
                "q"
                "<CMD>qa<CR>"
                "󰚑  Quit Neovim"
              )
            ];
          }
          {
            type = "padding";
            val = 1;
          }
          {
            type = "text";
            val = [
              "\"I hate programming\" - Myself"
            ];
            opts = {
              position = "center";
              hl = "AlphaFooter";
            };
          }
        ];
      };
    }
  ];
}
