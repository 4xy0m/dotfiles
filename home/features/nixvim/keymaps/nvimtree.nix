{...}: {
  programs.nixvim.keymaps = [
    {
      key = "<C-h>";
      action = "<cmd>NvimTreeToggle<CR>";
      options = {
        desc = "Nvimtree Toggle window";
      };
    }
    {
      key = "<leader>e";
      action = "<cmd>NvimTreeFocus<CR>";
      options = {
        desc = "Nvimtree Focus window";
      };
    }
  ];
}
