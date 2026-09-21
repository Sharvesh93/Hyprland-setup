return {
    -- Nerd Font Icons
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = {
            default = true,
        },
    },

    -- Clean Input & Select UI
    {
        "stevearc/dressing.nvim",
        lazy = true,
        init = function()
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
        opts = {
            input = {
                border = "rounded",
                win_options = { winblend = 0 },
            },
            select = {
                backend = { "telescope", "builtin" },
                builtin = { border = "rounded", win_options = { winblend = 0 } },
            },
        },
    },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = function()
            local transparent_theme = {
                normal = {
                    a = { fg = "#16161e", bg = "#7aa2f7", gui = "bold" },
                    b = { fg = "#7aa2f7", bg = "none" },
                    c = { fg = "#c0caf5", bg = "none" },
                },
                insert = {
                    a = { fg = "#16161e", bg = "#9ece6a", gui = "bold" },
                    b = { fg = "#9ece6a", bg = "none" },
                    c = { fg = "#c0caf5", bg = "none" },
                },
                visual = {
                    a = { fg = "#16161e", bg = "#bb9af7", gui = "bold" },
                    b = { fg = "#bb9af7", bg = "none" },
                    c = { fg = "#c0caf5", bg = "none" },
                },
                replace = {
                    a = { fg = "#16161e", bg = "#f7768e", gui = "bold" },
                    b = { fg = "#f7768e", bg = "none" },
                    c = { fg = "#c0caf5", bg = "none" },
                },
                command = {
                    a = { fg = "#16161e", bg = "#e0af68", gui = "bold" },
                    b = { fg = "#e0af68", bg = "none" },
                    c = { fg = "#c0caf5", bg = "none" },
                },
                inactive = {
                    a = { fg = "#565f89", bg = "none", gui = "bold" },
                    b = { fg = "#565f89", bg = "none" },
                    c = { fg = "#565f89", bg = "none" },
                },
            }

            return {
                options = {
                    theme = transparent_theme,
                    globalstatus = true,
                    component_separators = { left = "│", right = "│" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = { statusline = { "dashboard", "alpha", "neo-tree" } },
                },
                sections = {
                    lualine_a = { { "mode", icon = "" } },
                    lualine_b = { { "branch", icon = "󰊢" }, "diff" },
                    lualine_c = {
                        { "filename", path = 1, symbols = { modified = " ●", readonly = " 󰌾", unnamed = "[No Name]" } },
                    },
                    lualine_x = {
                        {
                            "diagnostics",
                            sources = { "nvim_diagnostic" },
                            symbols = { error = "󰅚 ", warn = "󰀪 ", info = "󰋽 ", hint = "󰌶 " },
                        },
                        "filetype",
                    },
                    lualine_y = { "progress" },
                    lualine_z = { { "location", icon = "" } },
                },
            }
        end,
    },

    -- Bufferline / Tabs
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
            { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
            { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
            { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
            { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
        },
        opts = {
            options = {
                mode = "buffers",
                separator_style = "thin",
                always_show_bufferline = false,
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(count, level)
                    local icon = level:match("error") and "󰅚 " or "󰀪 "
                    return " " .. icon .. count
                end,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
            },
            highlights = {
                fill = { bg = "none" },
                background = { bg = "none" },
                buffer_selected = { bg = "none", bold = true, italic = false },
                buffer_visible = { bg = "none" },
                separator = { fg = "#383e5a", bg = "none" },
                separator_selected = { fg = "#383e5a", bg = "none" },
                separator_visible = { fg = "#383e5a", bg = "none" },
                tab = { bg = "none" },
                tab_selected = { bg = "none" },
                tab_close = { bg = "none" },
                close_button = { bg = "none" },
                close_button_visible = { bg = "none" },
                close_button_selected = { bg = "none" },
                modified = { bg = "none" },
                modified_visible = { bg = "none" },
                modified_selected = { bg = "none" },
                indicator_selected = { fg = "#7aa2f7", bg = "none" },
            },
        },
    },

    -- Indentation Guides
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            indent = {
                char = "│",
                tab_char = "│",
            },
            scope = { enabled = true, show_start = false, show_end = false },
            exclude = {
                filetypes = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
            },
        },
    },

    -- Which-Key (Keybinding Discoverability)
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "modern",
            win = {
                border = "rounded",
                padding = { 1, 2 },
            },
            spec = {
                { "<leader>b", group = "Buffers" },
                { "<leader>c", group = "Code" },
                { "<leader>f", group = "Find / Telescope" },
                { "<leader>g", group = "Git" },
                { "<leader>l", group = "LSP / Diagnostics" },
                { "<leader>s", group = "Split Windows" },
                { "<leader>t", group = "Terminal" },
                { "<leader>u", group = "UI Toggles" },
            },
        },
    },

    -- Todo Comments
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = true,
        },
        keys = {
            { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
            { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
            { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find Todos" },
        },
    },
}
