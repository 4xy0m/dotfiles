{pkgs, ...}: {
  programs.nixvim.plugins.lazy.plugins = [
    {
      pkg = pkgs.vimPlugins.telescope-nvim;
      dependencies = [pkgs.vimPlugins.plenary-nvim pkgs.vimPlugins.telescope-fzf-native-nvim];
      config = ''
           function(_, opts)
           	local telescope = require "telescope"
        telescope.load_extension("fzf")
        telescope.setup(opts)
           end
      '';
      opts = {
        defaults = {
          vimgrep_arguments = [
            "${pkgs.ripgrep}/bin/rg"
            "-L"
            "--color=never"
            "--no-heading"
            "--with-filename"
            "--line-number"
            "--column"
            "--smart-case"
            "--fixed-strings"
          ];
          file_ignore_patterns = [
            "^node_modules/"
            "^.devenv/"
            "^.direnv/"
            "^.git/"
          ];
          prompt_prefix = "   ";
          selection_caret = "  ";
          entry_prefix = "  ";
          color_devicons = true;
          initial_mode = "insert";
          selection_strategy = "reset";
          sorting_strategy = "ascending";
          borderchars = [
            "─"
            "│"
            "─"
            "│"
            "╭"
            "╮"
            "╯"
            "╰"
          ];
          border = {};
          layout_strategy = "horizontal";
          layout_config = {
            horizontal = {
              prompt_position = "top";
              preview_width = 0.55;
              results_width = 0.8;
            };
            vertical = {
              mirror = false;
            };
            width = 0.87;
            height = 0.80;
            preview_cutoff = 120;
          };
        };
      };
    }
  ];
}
