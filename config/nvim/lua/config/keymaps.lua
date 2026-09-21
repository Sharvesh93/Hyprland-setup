-- Keybindings Configuration
local map = vim.keymap.set

-- -------------------------------------------------------------
-- General Editor Operations
-- -------------------------------------------------------------

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save File" })

-- Quit
map("n", "<leader>q", "<cmd>confirm q<CR>", { desc = "Quit Window" })
map("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Force Quit All" })

-- Clear search highlight on Esc
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Window Splits
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split Window Vertically" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split Window Horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make Splits Equal" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close Current Split" })

-- Buffer Management
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev Buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete Current Buffer" })
map("n", "<leader>bD", "<cmd>bdelete!<CR>", { desc = "Force Delete Buffer" })

-- Move lines up/down in Visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Selection Down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Selection Up" })

-- Keep cursor centered during scrolling / search navigation
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down Centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up Centered" })
map("n", "n", "nzzzv", { desc = "Next Search Result" })
map("n", "N", "Nzzzv", { desc = "Prev Search Result" })

-- Better indenting (stay in visual mode)
map("v", "<", "<gv", { desc = "Indent Left" })
map("v", ">", ">gv", { desc = "Indent Right" })

-- Diagnostics navigation
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "Diagnostics List" })

-- Quick toggle options
map("n", "<leader>uw", "<cmd>set wrap!<CR>", { desc = "Toggle Line Wrap" })
map("n", "<leader>un", "<cmd>set relativenumber!<CR>", { desc = "Toggle Relative Numbers" })
