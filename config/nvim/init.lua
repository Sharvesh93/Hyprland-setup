-- Leader key (must be set before plugins/keymaps)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core configuration
require("options")
require("keymaps")
require("autocmds")

-- Plugins
require("plugins.catppuccin")
