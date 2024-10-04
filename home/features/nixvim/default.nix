{myLib, ...}: let
  plugins = myLib.filesIn ./plugins;
  keymaps = myLib.filesIn ./keymaps;
in {
  imports = [] ++ plugins ++ keymaps;
  programs.nixvim = {
    enable = true;
    opts = {
      laststatus = 3;
      showmode = false;

      clipboard = "unnamedplus";
      cursorline = true;
      cursorlineopt = "number";

      expandtab = true;
      shiftwidth = 2;
      smartindent = true;
      tabstop = 2;
      softtabstop = 2;

      fillchars = { eob = " "; };
      ignorecase = true;
      smartcase = true;
      mouse = "a";

      number = true;
      numberwidth = 2;
      ruler = false;

      shortmess = "sI";

      signcolumn = "yes";
      splitbelow = true;
      splitright = true;
      timeoutlen = 400;
      undofile = true;

      updatetime = 250;

      whichwrap = "<>[]hl";
      relativenumber = true;
    };
    plugins.lazy.enable = true;
    globals.mapleader = " ";
  };
}
