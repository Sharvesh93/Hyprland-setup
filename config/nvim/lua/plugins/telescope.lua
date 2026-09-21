return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
            { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
            { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
            { "<leader>fc", function() require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") }) end, desc = "Neovim Config Files" },
        },
        opts = {
            defaults = {
                prompt_prefix = "   ",
                selection_caret = "  ",
                entry_prefix = "  ",
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                        results_width = 0.8,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },
                borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                mappings = {
                    i = {
                        ["<C-n>"] = function(...) return require("telescope.actions").move_selection_next(...) end,
                        ["<C-p>"] = function(...) return require("telescope.actions").move_selection_previous(...) end,
                        ["<C-c>"] = function(...) return require("telescope.actions").close(...) end,
                        ["<C-j>"] = function(...) return require("telescope.actions").move_selection_next(...) end,
                        ["<C-k>"] = function(...) return require("telescope.actions").move_selection_previous(...) end,
                        ["<CR>"] = function(...) return require("telescope.actions").select_default(...) end,
                    },
                },
            },
        },
    },
}
