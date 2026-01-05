require("core.options")
require("core.keymaps")
require("core.ui")

require("plugins.lazy")
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    local ok, err = pcall(function()
      require("lsp").setup()
    end)
    
    if not ok then
      vim.notify("LSP setup failed: " .. tostring(err), vim.log.levels.ERROR)
    end
  end,
})

