-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {
  nvdash = {
    load_on_startup = true,
  }
}

M.base46 = {
	theme = "catppuccin",

  changed_themes = {
    catppuccin = {
      base_16 = {
        base00 = "NONE",
      },
    },
  },

	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},
}

return M
