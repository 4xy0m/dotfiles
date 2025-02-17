require "nvchad.options"

vim.wo.relativenumber = true

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    local filename = vim.api.nvim_buf_get_name(0)
    local dirname = filename:match("(.*/)")
    os.execute(string.format("ya emit-to $(expr $ZELLIJ_PANE_ID - 1) cd %s", dirname))
    os.execute(string.format("ya emit-to $(expr $ZELLIJ_PANE_ID - 1) hove %s", filename))
  end
})
