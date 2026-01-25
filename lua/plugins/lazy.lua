local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = false,
        styles = { sidebars = "dark", floats = "dark" },
        on_colors = function(c)
          c.bg = "#0d1117"
          c.bg_dark = "#010409"
          c.bg_highlight = "#161b22"
          c.blue = "#79c0ff"
          c.cyan = "#56d4dd"
          c.green = "#7ee787"
          c.magenta = "#d2a8ff"
          c.purple = "#bc8cff"
          c.red = "#ff7b72"
          c.yellow = "#ffd866"
          c.orange = "#ffa657"
          c.pink = "#ff9bce"
          c.teal = "#39d353"
          c.comment = "#8b949e"
        end,
        on_highlights = function(hl, c)
          hl.CursorLine = { bg = "#1c2128" }
          hl.CursorLineNr = { fg = "#ff9bce", bold = true }
          hl.LineNr = { fg = "#6e7681" }
          hl.LineNrAbove = { fg = "#bc8cff" }
          hl.LineNrBelow = { fg = "#bc8cff" }
          hl.Function = { fg = "#d2a8ff", italic = true }
          hl.Keyword = { fg = "#ff7b72", bold = true }
          hl.String = { fg = "#a5d6ff" }
          hl.Type = { fg = "#79c0ff" }
          hl.Operator = { fg = "#ff9bce" }
          hl.Statement = { fg = "#ff7b72" }
          hl.Constant = { fg = "#ffa657" }
          hl.Number = { fg = "#ffd866" }
          hl.Boolean = { fg = "#ff9bce", bold = true }
          hl.Comment = { fg = "#8b949e", italic = true }
          hl.TelescopeBorder = { fg = "#bc8cff" }
          hl.TelescopePromptBorder = { fg = "#ff9bce" }
          hl.TelescopePromptTitle = { fg = "#0d1117", bg = "#ff9bce", bold = true }
          hl.TelescopePreviewTitle = { fg = "#0d1117", bg = "#bc8cff", bold = true }
          hl.TelescopeResultsTitle = { fg = "#0d1117", bg = "#79c0ff", bold = true }
          hl.NvimTreeFolderIcon = { fg = "#bc8cff" }
          hl.NvimTreeGitNew = { fg = "#7ee787" }
          hl.NvimTreeGitDirty = { fg = "#ffd866" }
          hl.NvimTreeGitDeleted = { fg = "#ff7b72" }
          hl.NvimTreeRootFolder = { fg = "#ff9bce", bold = true }
          hl.IndentBlanklineChar = { fg = "#21262d" }
          hl.IndentBlanklineContextChar = { fg = "#bc8cff" }
          hl.IblIndent = { fg = "#21262d" }
          hl.IblScope = { fg = "#bc8cff" }
          hl.NoiceCmdlinePopupBorder = { fg = "#bc8cff" }
          hl.NoiceCmdlineIcon = { fg = "#ff9bce" }
          hl.NotifyINFOBorder = { fg = "#79c0ff" }
          hl.NotifyWARNBorder = { fg = "#ffd866" }
          hl.NotifyERRORBorder = { fg = "#ff7b72" }
          hl.FlashLabel = { fg = "#0d1117", bg = "#ff9bce", bold = true }
          hl.FloatBorder = { fg = "#bc8cff" }
          hl.NormalFloat = { bg = "#161b22" }
        end,
      })
      vim.cmd.colorscheme "tokyonight"
    end
  },

  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "markdown" },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      telescope.setup({
        defaults = {
          prompt_prefix = "   ",
          selection_caret = "  ",
          entry_prefix = "   ",
          multi_icon = " 󰛄 ",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            width = 0.87,
            height = 0.80,
          },
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/" },
          path_display = { "truncate" },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<Esc>"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = { hidden = true, previewer = false, layout_config = { width = 0.5, height = 0.6 } },
          buffers = { previewer = false, layout_config = { width = 0.5, height = 0.6 } },
        },
      })
      telescope.load_extension("fzf")
    end
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
  },

  { "williamboman/mason.nvim", cmd = "Mason", config = true },

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
        automatic_installation = true,
      })
    end
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        window = {
          completion = { border = "rounded", winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None" },
          documentation = { border = "rounded" },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() and cmp.get_selected_entry() then
              cmp.confirm({ select = true })
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, { name = "luasnip" }, { name = "buffer" }, { name = "path" },
        }),
      })
    end
  },

  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
  { "numToStr/Comment.nvim", event = "VeryLazy", config = true },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = { add = { text = "│" }, change = { text = "│" }, delete = { text = "󰍵" }, topdelete = { text = "󰍷" }, changedelete = { text = "󰍴" }, untracked = { text = "┆" } },
        signs_staged = { add = { text = "│" }, change = { text = "│" }, delete = { text = "󰍵" }, topdelete = { text = "󰍷" }, changedelete = { text = "󰍴" } },
        current_line_blame = true,
        current_line_blame_opts = { delay = 500, virt_text_pos = "eol" },
        current_line_blame_formatter = "   <author>, <author_time:%R> • <summary>",
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local map = function(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc }) end
          map("n", "]h", gs.next_hunk, "Next hunk")
          map("n", "[h", gs.prev_hunk, "Prev hunk")
          map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
          map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
          map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
          map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage")
          map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
          map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
          map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
          map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage selection")
          map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset selection")
        end,
      })
    end
  },

  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git diff" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Branch history" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close diff" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = { layout = "diff2_horizontal" },
        merge_tool = { layout = "diff3_mixed" },
      },
      file_panel = { win_config = { position = "left", width = 35 } },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = { theme = "tokyonight", component_separators = { left = "", right = "" }, section_separators = { left = "", right = "" }, globalstatus = true },
        sections = {
          lualine_a = { { "mode", fmt = function(s) return s:sub(1,3) end } },
          lualine_b = { "branch" },
          lualine_c = { { "filename", path = 1, symbols = { modified = "●", readonly = "󰌾" } } },
          lualine_x = { { "diagnostics", symbols = { error = "E", warn = "W", info = "I", hint = "H" } } },
          lualine_y = { "filetype" },
          lualine_z = { "location" },
        },
      })
    end
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = { indent = { char = "▏", tab_char = "▏" }, scope = { enabled = true, show_start = true, show_end = false, highlight = { "Function", "Label" } } },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function() vim.o.timeout = true vim.o.timeoutlen = 300 end,
    config = true,
  },

  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({ keymaps = { accept_suggestion = "<C-y>" }, log_level = "off" })
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = { { "<leader>e", "<cmd>NvimTreeToggle<cr>" }, { "<leader>o", "<cmd>NvimTreeFocus<cr>" } },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_netrw = true,
        sort_by = "case_sensitive",
        sync_root_with_cwd = true,
        view = { width = 32, side = "left", number = false, relativenumber = false, cursorline = true },
        renderer = {
          group_empty = true,
          highlight_git = true,
          highlight_opened_files = "all",
          root_folder_label = ":t",
          indent_width = 2,
          indent_markers = { enable = true, inline_arrows = true, icons = { corner = "╰", edge = "│", item = "├", bottom = "─", none = " " } },
          icons = {
            web_devicons = { file = { enable = true, color = true }, folder = { enable = true, color = true } },
            git_placement = "signcolumn",
            padding = " ",
            glyphs = {
              default = "󰈙", symlink = "", bookmark = "󰆤",
              folder = { default = "󰉋", empty = "󰉖", empty_open = "󰷏", open = "󰝰", symlink = "󰉒", symlink_open = "󰉒", arrow_open = "", arrow_closed = "" },
              git = { unstaged = "●", staged = "✓", unmerged = "", renamed = "➜", untracked = "◌", deleted = "✖", ignored = "◌" },
            },
          },
          special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "package.json" },
        },
        filters = { dotfiles = false, custom = { "^.git$", "node_modules", ".cache" } },
        actions = { open_file = { quit_on_open = false, window_picker = { enable = true } } },
        git = { enable = true, ignore = false },
      })
    end,
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          style_preset = require("bufferline").style_preset.minimal,
          themable = true,
          numbers = "none",
          close_command = "bdelete! %d",
          right_mouse_command = "bdelete! %d",
          indicator = { icon = "▎", style = "icon" },
          buffer_close_icon = "󰅖", modified_icon = "●", close_icon = "", left_trunc_marker = "", right_trunc_marker = "",
          max_name_length = 30, max_prefix_length = 30,
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, level) return " " .. (level:match("error") and " " or " ") .. count end,
          offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center", separator = true } },
          separator_style = "thin",
          show_buffer_close_icons = true, show_close_icon = true, show_tab_indicators = true,
          persist_buffer_sort = true, enforce_regular_tabs = false, always_show_bufferline = true,
          hover = { enabled = true, delay = 200, reveal = { "close" } },
        },
        highlights = { buffer_selected = { bold = true, italic = false } },
      })
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>s", "<cmd>SymbolsOutline<cr>" } },
    config = function()
      require("symbols-outline").setup({
        width = 25, autofold_depth = 1, auto_unfold_hover = true,
        symbols = {
          File = { icon = "", hl = "@text.uri" }, Module = { icon = "", hl = "@namespace" },
          Namespace = { icon = "", hl = "@namespace" }, Package = { icon = "", hl = "@namespace" },
          Class = { icon = "", hl = "@type" }, Method = { icon = "", hl = "@method" },
          Property = { icon = "", hl = "@method" }, Field = { icon = "", hl = "@field" },
          Constructor = { icon = "", hl = "@constructor" }, Enum = { icon = "", hl = "@type" },
          Interface = { icon = "", hl = "@type" }, Function = { icon = "", hl = "@function" },
          Variable = { icon = "", hl = "@constant" }, Constant = { icon = "", hl = "@constant" },
          String = { icon = "", hl = "@string" }, Number = { icon = "#", hl = "@number" },
          Boolean = { icon = "", hl = "@boolean" }, Array = { icon = "", hl = "@constant" },
          Object = { icon = "", hl = "@type" }, Key = { icon = "", hl = "@type" },
          Null = { icon = "NULL", hl = "@type" }, EnumMember = { icon = "", hl = "@field" },
          Struct = { icon = "", hl = "@type" }, Event = { icon = "", hl = "@type" },
          Operator = { icon = "+", hl = "@operator" }, TypeParameter = { icon = "", hl = "@parameter" },
        },
      })
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = { user_default_options = { RGB = true, RRGGBB = true, names = false, RRGGBBAA = true, rgb_fn = true, hsl_fn = true, css = true, css_fn = true, mode = "background" } },
  },

  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      require("neoscroll").setup({ mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" }, hide_cursor = true, stop_eof = true, respect_scrolloff = false, cursor_scrolls_alone = true, easing_function = "quadratic" })
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      require("notify").setup({ background_colour = "#0d1117", fps = 60, render = "compact", stages = "fade_in_slide_out", timeout = 2500, max_width = 50 })
      require("noice").setup({
        lsp = { override = { ["vim.lsp.util.convert_input_to_markdown_lines"] = true, ["vim.lsp.util.stylize_markdown"] = true, ["cmp.entry.get_documentation"] = true }, progress = { enabled = true, view = "mini" } },
        presets = { bottom_search = false, command_palette = true, long_message_to_split = true, lsp_doc_border = true },
        cmdline = { enabled = true, view = "cmdline_popup", format = { cmdline = { pattern = "^:", icon = "", lang = "vim" }, search_down = { kind = "search", pattern = "^/", icon = "", lang = "regex" }, search_up = { kind = "search", pattern = "^%?", icon = "", lang = "regex" }, filter = { pattern = "^:%s*!", icon = "$", lang = "bash" }, lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" }, help = { pattern = "^:%s*he?l?p?%s+", icon = "?" } } },
        messages = { enabled = true, view = "notify", view_error = "notify", view_warn = "notify" },
        popupmenu = { enabled = true, backend = "nui" },
        views = { cmdline_popup = { border = { style = "rounded", padding = { 0, 1 } }, position = { row = "40%", col = "50%" }, size = { width = 60, height = "auto" } }, popupmenu = { relative = "editor", border = { style = "rounded", padding = { 0, 1 } } } },
      })
    end,
  },

  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = { input = { enabled = true, default_prompt = "➤ ", border = "rounded", relative = "cursor", prefer_width = 40, win_options = { winblend = 0 } }, select = { enabled = true, backend = { "telescope", "builtin" } } },
  },

  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = { { "]t", function() require("todo-comments").jump_next() end }, { "[t", function() require("todo-comments").jump_prev() end }, { "<leader>ft", "<cmd>TodoTelescope<cr>" } },
    opts = { signs = true, keywords = { FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } }, TODO = { icon = " ", color = "info" }, HACK = { icon = " ", color = "warning" }, WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } }, PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } }, NOTE = { icon = " ", color = "hint", alt = { "INFO" } } }, highlight = { before = "", keyword = "wide", after = "fg" } },
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = { { "<C-\\>", "<cmd>ToggleTerm direction=float<cr>" }, { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>" }, { "<leader>th", "<cmd>ToggleTerm direction=horizontal size=15<cr>" }, { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>" } },
    opts = { size = function(term) if term.direction == "horizontal" then return 15 elseif term.direction == "vertical" then return vim.o.columns * 0.4 end end, open_mapping = [[<C-\>]], hide_numbers = true, shade_terminals = true, shading_factor = 2, start_in_insert = true, insert_mappings = true, terminal_mappings = true, persist_size = true, direction = "float", close_on_exit = true, shell = vim.o.shell, float_opts = { border = "curved", winblend = 0 } },
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = { { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>" }, { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>" }, { "<leader>xl", "<cmd>Trouble loclist toggle<cr>" }, { "<leader>xq", "<cmd>Trouble qflist toggle<cr>" } },
    opts = { position = "bottom", icons = true, auto_close = true, auto_preview = true, signs = { error = "", warning = "", hint = "", information = "", other = "" } },
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = { { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end }, { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end }, { "r", mode = "o", function() require("flash").remote() end }, { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end } },
    opts = { labels = "asdfghjklqwertyuiopzxcvbnm", search = { multi_window = true }, jump = { autojump = false }, label = { uppercase = false, rainbow = { enabled = true, shade = 5 } }, modes = { char = { enabled = true, jump_labels = true } } },
  },

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#6e7681" })
      vim.api.nvim_set_hl(0, "DashboardCenter", { fg = "#bc8cff" })
      vim.api.nvim_set_hl(0, "DashboardShortCut", { fg = "#79c0ff" })
      vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#8b949e", italic = true })
      require("dashboard").setup({
        theme = "doom",
        config = {
          header = {
            "",
            [[@@@@@@@@%@@@@@@@@@@@@@%%@@@@@@@@@@@@@@@%####%@@@@@@@@@@@@@%######%%*:....                   ..:@@@]],
            [[@@@@@@#%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%###%@@@@@@@@@@@@@@@@@@@@@@%#%@@@%+-:......         ...:-+@@@@]],
            [[@@@@#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%#+=-::...:..:-#@@@@@@@@]],
            [[@@%#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%#@@@@@@@@@@@@@%@@@@@@%-#@@@@@@@@@@@]],
            [[@%%@@@#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%@@@@@+%@@@@@@@@@@@@]],
            [[#@@@%*@%##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%@@@@@@@@@@@@@@@@@@@]],
            [[#@@@#%@#%%%@%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%@@@@@@@@@@@@@@@@@@@]],
            [[%@@@@@%#%@%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%%#%%%%%@@@@@@@@@@@%*++#@@@#@@@@@@@@@@@@@@@@@@@@@]],
            [[@@#@@@@%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%#%###**++++=++==++++%@@%@@@#=====+#@%@@@@@@@@@@@@@@@@@@@]],
            [[@@#@@@@@@@@@@@%@@@@@@@@@@@@@@@@@@@@%@@@%###***+++++=--====+=====*%@##@@#+----==%%@@@@@@@@@@@@@@@@@@@]],
            [[@@#@@@@@@@@@@#%@@@@%@@@@@@@@@%%%#%#++****+**++++++=-------======+#@%*%@%=------*#@@@@@@@@@@@@@@@@@@@]],
            [[@@#@@@@@@@@@##@@%*#@@@@@##**+=-------------------===-------=+++++#@%*#@@+=---==+#@@@@@@@@@@@@@@@@@@@]],
            [[@@%@@@@@@@@#*@@%*#@%@@@*----------------------------------=-===+++%%*+%@*====--+#@@@@@@@@@@@@@@@@@@@]],
            [[@@%@@@@@@@##@@*#@@@@@@+--------==-===--------------===------=====*%*+#@%+-----+*%@@@@@@@@@@@@@@@@@@]],
            [[@@#@@@@@@@*@@##@@@@@@@+----------------------------==-------=====+#++*%@#=--=+=+%@@@@@@@@@@@@@@@@@@]],
            [[@@#@@@@@@@@@%*@@@@@@%@+-----------------------------==---=---==+==*+-+#@#=-----=#@@@@@@@@@@@@@@@@@@]],
            [[@@#@@@@@@@@@%%@@@@@%*@+-----------------==-===-------==--------==-+=--*@@+------*@@@@@@@@@@@@@@@@@@]],
            [[@@%@@@@@@@@@@@@@@@@#=@*=--------------========-----+#%*=-------=****+==%@*------+#@@@@@@@@@@@@@@@@@]],
            [[@@#@@@%*+%@@@@@@@@@#=##---------===---=+=----==---+%@#*+--------=++=---*@#=-----=#%@@@@@@@@@@@@@@@@]],
            [[@@##@@+=--*@@@@@@@@#-*%----=+*%@@@@%*=--=-----++-=++==++=--------=+=---*@@==--===+#@@@@@@@@@@@@@@@@]],
            [[@@#+*@@+==-=%@@@@@@#-=%+*%@@%#######%%*==+===--=+=====+===--------==--=+#%========*%@@@@@@@@@@@@@@@]],
            [[@@+@=@@@+===-#@@@@@%+=*+--+===+=++====++==+=---==++=-*@@@%+----==-=+=-=***+=------+#@@@@@@@@@@@@@@@]],
            [[@@*@#%@+@*+===#@%@@%--=#---====+*%%*===+=-==---------+*-:++---------+==##=+=-------*@@@@@@@@@@@@@@@]],
            "",
            "",
          },
          center = {
            { icon = " 󰈞 ", icon_hl = "DashboardShortCut", desc = "Find File       ", desc_hl = "DashboardCenter", key = "f", key_hl = "DashboardShortCut", action = "Telescope find_files" },
            { icon = " 󰋚 ", icon_hl = "DashboardShortCut", desc = "Recent          ", desc_hl = "DashboardCenter", key = "r", key_hl = "DashboardShortCut", action = "Telescope oldfiles" },
            { icon = " 󰊄 ", icon_hl = "DashboardShortCut", desc = "Grep            ", desc_hl = "DashboardCenter", key = "g", key_hl = "DashboardShortCut", action = "Telescope live_grep" },
            { icon = " 󰙅 ", icon_hl = "DashboardShortCut", desc = "Files           ", desc_hl = "DashboardCenter", key = "e", key_hl = "DashboardShortCut", action = "NvimTreeToggle" },
            { icon = " 󰒓 ", icon_hl = "DashboardShortCut", desc = "Config          ", desc_hl = "DashboardCenter", key = "c", key_hl = "DashboardShortCut", action = "e ~/.config/nvim/init.lua" },
            { icon = " 󰩈 ", icon_hl = "DashboardShortCut", desc = "Quit            ", desc_hl = "DashboardCenter", key = "q", key_hl = "DashboardShortCut", action = "qa" },
          },
          footer = function()
            local stats = require("lazy").stats()
            return {
              "",
              "⚡ " .. stats.count .. " plugins · " .. string.format("%.0f", stats.startuptime) .. "ms",
              "",
              "The owl of Minerva spreads its wings only with the falling of the dusk.",
              "— Hegel",
            }
          end,
        },
      })
    end,
  },
}
