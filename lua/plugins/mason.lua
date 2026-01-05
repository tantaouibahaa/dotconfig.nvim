return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "jay-babu/mason-null-ls.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_null_ls = require("mason-null-ls")

    -- Configure Mason
    mason.setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      max_concurrent_installers = 4,
    })

    -- Configure Mason LSP
    mason_lspconfig.setup({
      ensure_installed = {
        "rust_analyzer",
        "ts_ls",
        "pyright",
        "gopls",
        "hls",
        "clangd",
        "lua_ls",
      },
      automatic_installation = true,
    })

    -- Configure Mason Null-ls
    mason_null_ls.setup({
      ensure_installed = {
        -- Formatters
        "rustfmt",
        "stylua",
        "prettier",
        "black",
        "isort",
        "gofumpt",
        "goimports",
        "fourmolu",
        "clang-format",
        "cmake-format",
        "uncrustify",

        -- Linters
        "eslint",
        "flake8",
        "golangci-lint",
        "hlint",
        "clang-check",
        "cmake-lint",

        -- Code actions
        "shellcheck",
      },
      automatic_installation = true,
      automatic_setup = true,
    })
  end,
} 
