local opt = vim.opt

opt.updatetime = 250
opt.timeoutlen = 300
opt.redrawtime = 1500

opt.termguicolors = true
opt.pumheight = 10
opt.pumblend = 0
opt.winblend = 0
opt.cmdheight = 0
opt.laststatus = 3
opt.showmode = false
opt.showcmd = false
opt.ruler = false
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.fillchars = {
  eob = " ",
  fold = " ",
  foldopen = "▾",
  foldsep = " ",
  foldclose = "▸",
}

-- Editing
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.wrap = true
opt.breakindent = true
opt.breakindentopt = "shift:2"
opt.showbreak = "  "
opt.linebreak = true
opt.scrolloff = 4
opt.sidescrolloff = 4
opt.splitbelow = true
opt.splitright = true

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.completeopt = "menuone,noselect"
opt.shortmess:append "c"

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false
opt.foldlevel = 99

local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "
