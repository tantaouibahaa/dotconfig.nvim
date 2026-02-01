-- Manual command: displays all keybindings in a formatted buffer

local M = {}

local keybindings = {
  {
    category = "Navigation",
    bindings = {
      { "<C-h>", "Move to left window" },
      { "<C-j>", "Move to window below" },
      { "<C-k>", "Move to window above" },
      { "<C-l>", "Move to right window" },
      { "<C-d>", "Scroll down (centered)" },
      { "<C-u>", "Scroll up (centered)" },
      { "n", "Next search result (centered)" },
      { "N", "Previous search result (centered)" },
    },
  },
  {
    category = "Buffers",
    bindings = {
      { "<S-l>", "Next buffer" },
      { "<S-h>", "Previous buffer" },
      { "<leader>c", "Close buffer" },
      { "<leader>bc", "Pick buffer to close" },
      { "<leader>bp", "Pick buffer" },
    },
  },
  {
    category = "File Explorer",
    bindings = {
      { "<leader>e", "Toggle NvimTree" },
      { "<leader>o", "Focus NvimTree" },
    },
  },
  {
    category = "Search (Telescope)",
    bindings = {
      { "<leader>ff", "Find files" },
      { "<leader>fg", "Live grep" },
      { "<leader>fb", "Find buffers" },
      { "<leader>fr", "Recent files" },
      { "<leader>ft", "Find TODOs" },
    },
  },
  {
    category = "LSP",
    bindings = {
      { "gd", "Go to definition" },
      { "K", "Hover documentation" },
      { "<leader>la", "Code action" },
      { "<leader>lr", "Rename symbol" },
      { "<leader>lf", "Format buffer" },
      { "[d", "Previous diagnostic" },
      { "]d", "Next diagnostic" },
    },
  },
  {
    category = "Git",
    bindings = {
      { "]h", "Next hunk" },
      { "[h", "Previous hunk" },
      { "<leader>hp", "Preview hunk" },
      { "<leader>hs", "Stage hunk" },
      { "<leader>hr", "Reset hunk" },
      { "<leader>hu", "Undo stage hunk" },
      { "<leader>hS", "Stage buffer" },
      { "<leader>hR", "Reset buffer" },
      { "<leader>hb", "Blame line" },
      { "<leader>gd", "Git diff" },
      { "<leader>gh", "File history" },
      { "<leader>gH", "Branch history" },
      { "<leader>gc", "Close diff" },
    },
  },
  {
    category = "Terminal",
    bindings = {
      { "<C-\\>", "Toggle floating terminal" },
      { "<leader>tf", "Float terminal" },
      { "<leader>th", "Horizontal terminal" },
      { "<leader>tv", "Vertical terminal" },
    },
  },
  {
    category = "Diagnostics (Trouble)",
    bindings = {
      { "<leader>xx", "Toggle diagnostics" },
      { "<leader>xX", "Buffer diagnostics" },
      { "<leader>xl", "Location list" },
      { "<leader>xq", "Quickfix list" },
    },
  },
  {
    category = "Motion (Flash)",
    bindings = {
      { "s", "Flash jump" },
      { "S", "Flash treesitter" },
      { "r", "Flash remote (operator)" },
      { "R", "Flash treesitter search" },
    },
  },
  {
    category = "Editing",
    bindings = {
      { "<A-j>", "Move line down" },
      { "<A-k>", "Move line up" },
      { "<", "Indent left (visual)" },
      { ">", "Indent right (visual)" },
      { "p", "Paste without yanking (visual)" },
      { "<Esc>", "Clear search highlight" },
    },
  },
  {
    category = "Splits",
    bindings = {
      { "<leader>sv", "Vertical split" },
      { "<leader>sh", "Horizontal split" },
      { "<leader>se", "Equalize splits" },
      { "<leader>sx", "Close split" },
      { "<C-Up>", "Resize up" },
      { "<C-Down>", "Resize down" },
      { "<C-Left>", "Resize left" },
      { "<C-Right>", "Resize right" },
    },
  },
  {
    category = "AI (Supermaven)",
    bindings = {
      { "<Tab>", "Accept suggestion" },
      { "<C-y>", "Accept suggestion (alt)" },
    },
  },
  {
    category = "Other",
    bindings = {
      { "<leader>w", "Save file" },
      { "<leader>q", "Quit" },
      { "<leader>z", "Zen mode" },
      { "<leader>s", "Symbols outline" },
      { "<leader>?", "WhichKey" },
      { "]t", "Next TODO" },
      { "[t", "Previous TODO" },
    },
  },
}

local function create_manual_buffer()
  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(buf, "swapfile", false)
  vim.api.nvim_buf_set_option(buf, "filetype", "manual")

  -- Build content
  local lines = {}
  local width = 60

  -- Header
  table.insert(lines, string.rep("═", width))
  local title = "NEOVIM KEYBINDINGS MANUAL"
  local padding = math.floor((width - #title) / 2)
  table.insert(lines, string.rep(" ", padding) .. title)
  table.insert(lines, string.rep("═", width))
  table.insert(lines, "")
  table.insert(lines, "  Leader key: <Space>")
  table.insert(lines, "  Press 'q' or '<Esc>' to close this window")
  table.insert(lines, "")

  -- Categories
  for _, cat in ipairs(keybindings) do
    table.insert(lines, string.rep("─", width))
    table.insert(lines, "  " .. cat.category)
    table.insert(lines, string.rep("─", width))
    for _, binding in ipairs(cat.bindings) do
      local key = binding[1]
      local desc = binding[2]
      local key_col = string.format("  %-16s", key)
      table.insert(lines, key_col .. desc)
    end
    table.insert(lines, "")
  end

  table.insert(lines, string.rep("═", width))

  -- Set lines
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Make buffer read-only
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  vim.api.nvim_buf_set_option(buf, "readonly", true)

  -- Open in a new window
  local win_height = math.min(#lines + 2, math.floor(vim.o.lines * 0.8))
  local win_width = math.min(width + 4, math.floor(vim.o.columns * 0.8))
  local row = math.floor((vim.o.lines - win_height) / 2)
  local col = math.floor((vim.o.columns - win_width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " Manual ",
    title_pos = "center",
  })

  -- Set window options
  vim.api.nvim_win_set_option(win, "cursorline", true)
  vim.api.nvim_win_set_option(win, "wrap", false)

  -- Keymaps to close the buffer
  local close_keys = { "q", "<Esc>" }
  for _, key in ipairs(close_keys) do
    vim.api.nvim_buf_set_keymap(buf, "n", key, "<cmd>close<cr>", { noremap = true, silent = true })
  end
end

-- Register the command
vim.api.nvim_create_user_command("Manual", create_manual_buffer, { desc = "Show keybindings manual" })

return M
