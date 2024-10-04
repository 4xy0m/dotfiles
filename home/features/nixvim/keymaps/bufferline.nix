{...}: {
  programs.nixvim.keymaps = [
    {
      key = "<tab>";
      action = "<cmd>BufferLineCycleNext<CR>";
    }
    {
      key = "<S-tab>";
      action = "<cmd>BufferLineCyclePrev<CR>";
    }
    {
      key = "<leader>x";
      action = "<cmd>Bdelete<CR>";
    }
  ];
}
