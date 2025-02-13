return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "nix",
        "rust", "python", "javascript",
        "typescript", "svelte", "graphql",
        "java", "json", "sql"
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require "configs.noice"
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    'RaafatTurki/hex.nvim',
    event = "VeryLazy",
    config = function()
      require 'hex'.setup()
    end
  },
  {
    'nvimtools/none-ls.nvim',
    event = "VeryLazy",
    config = function()
      require "configs.nonels"
    end,
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    {
      "swaits/zellij-nav.nvim",
      lazy = true,
      event = "VeryLazy",
      keys = {
        { "<c-left>",  "<cmd>ZellijNavigateLeftTab<cr>",  { silent = true, desc = "navigate left or tab" } },
        { "<c-down>",  "<cmd>ZellijNavigateDown<cr>",     { silent = true, desc = "navigate down" } },
        { "<c-up>",    "<cmd>ZellijNavigateUp<cr>",       { silent = true, desc = "navigate up" } },
        { "<c-right>", "<cmd>ZellijNavigateRightTab<cr>", { silent = true, desc = "navigate right or tab" } },
      },
      opts = {},
    },
  }
}
