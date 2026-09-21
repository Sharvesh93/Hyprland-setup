-- Neovim General Options
local opt = vim.opt

-- Line Numbers
opt.number = true
opt.relativenumber = true

-- Tabs & Indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line Wrapping
opt.wrap = false

-- Search Settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Cursor & Visuals
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.fillchars = { eob = " " } -- Hide ~ on empty lines

-- Clipboard & Mouse
opt.mouse = "a"
opt.clipboard = "unnamedplus"

-- Window Splits
opt.splitright = true
opt.splitbelow = true

-- Backup & Undo
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- Responsiveness & Update Times
opt.updatetime = 200
opt.timeoutlen = 300

-- Popup Menu
opt.pumheight = 10
opt.completeopt = { "menu", "menuone", "noselect" }

-- Conceallevel for Markdown & json
opt.conceallevel = 0

-- Disable unused remote providers for speed
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0
