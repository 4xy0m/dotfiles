{...}: {
  programs.nixvim = {
    keymaps = [
      {
        action = "<cmd>Telescope find_files<CR>";
        key = "<leader>ff";
        options.desc = "Find files";
        mode = [
          "n"
        ];
      }
      {
        action = "<cmd>Telescope buffers<CR>";
        key = "<leader>fb";
        options.desc = "Find buffers";
        mode = [
          "n"
        ];
      }
      {
        action = "<cmd>Telescope oldfiles<CR>";
        key = "<leader>fr";
        options.desc = "Recent files";
        mode = [
          "n"
        ];
      }
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>fg";
        options.desc = "Grep";
        mode = [
          "n"
        ];
      }
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>fg";
        options.desc = "Grep";
        mode = [
          "n"
        ];
      }
    ];
  };
}
