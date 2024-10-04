{...}: {
  programs.nixvim.keymaps = [
    {
      key = "<C-Left>";
      action = "<cmd>ZellijNavigateLeft<CR>";
      options.noremap = true;
    }
    {
      key = "<C-Right>";
      action = "<cmd>ZellijNavigateRight<CR>";
      options.noremap = true;
    }
    {
      key = "<C-Down>";
      action = "<cmd>ZellijNavigateDown<CR>";
      options.noremap = true;
    }
    {
      key = "<C-Up>";
      action = "<cmd>ZellijNavigateUp<CR>";
      options.noremap = true;
    }
  ];
}
