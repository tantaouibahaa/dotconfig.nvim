local M = {}

function M.setup()
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  local on_attach = function( bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end
  local servers = { "lua_ls", "ts_ls", "pyright" }
  for _, server in ipairs(servers) do
    local opts = {
      capabilities = capabilities,
      on_attach = on_attach,
    }
    
    if server == "lua_ls" then
      opts.settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      }
    end
    lspconfig[server].setup(opts)
  end
end

return M
