{...}: {
  programs.nixvim = {
    keymaps = [
      {
        key = "<Esc>";
        action = "<cmd>noh<CR>";
        mode = ["n"];
      }
      {
        key = "<C-s>";
        action = "<cmd>w<CR>";
      }
      {
        key = "<C-c>";
        action = "<cmd>%y+<CR>";
      }
      {
        key = "<leader>fm";
        action = "<cmd>lua vim.lsp.buf.format()<CR>";
        mode = ["n"];
      }
    ];
  };
}
