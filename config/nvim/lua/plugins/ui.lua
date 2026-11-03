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

    -- Minimal Transparent Statusline matching Wallpaper palette
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = function()
            local ok, mc = pcall(require, "generated.colors")
            local primary = (ok and mc.primary) or "#f2be6e"
            local tertiary = (ok and mc.tertiary) or "#b7cea2"
            local secondary = (ok and mc.secondary) or "#dcc3a1"
            local error_col = (ok and mc.error) or "#ffb4ab"
            local text_col = (ok and mc.text) or "#ede1d4"
            local on_primary = (ok and mc.on_primary) or "#18130b"

            local transparent_theme = {
                normal = {
                    a = { fg = on_primary, bg = primary, gui = "bold" },
                    b = { fg = primary, bg = "none" },
                    c = { fg = text_col, bg = "none" },
                },
                insert = {
                    a = { fg = on_primary, bg = tertiary, gui = "bold" },
                    b = { fg = tertiary, bg = "none" },
                    c = { fg = text_col, bg = "none" },
                },
                visual = {
                    a = { fg = on_primary, bg = secondary, gui = "bold" },
                    b = { fg = secondary, bg = "none" },
                    c = { fg = text_col, bg = "none" },
                },
                replace = {
                    a = { fg = on_primary, bg = error_col, gui = "bold" },
                    b = { fg = error_col, bg = "none" },
                    c = { fg = text_col, bg = "none" },
                },
                command = {
                    a = { fg = on_primary, bg = primary, gui = "bold" },
                    b = { fg = primary, bg = "none" },
                    c = { fg = text_col, bg = "none" },
                },
                inactive = {
                    a = { fg = text_col, bg = "none", gui = "bold" },
                    b = { fg = text_col, bg = "none" },
                    c = { fg = text_col, bg = "none" },
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

    -- Minimal Transparent Bufferline / Tabs
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
        opts = function()
            local ok, mc = pcall(require, "generated.colors")
            local primary = (ok and mc.primary) or "#f2be6e"
            local outline = (ok and mc.outline_variant) or "#383e5a"

            return {
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
                    buffer_selected = { fg = primary, bg = "none", bold = true, italic = false },
                    buffer_visible = { bg = "none" },
                    separator = { fg = outline, bg = "none" },
                    separator_selected = { fg = outline, bg = "none" },
                    separator_visible = { fg = outline, bg = "none" },
                    tab = { bg = "none" },
                    tab_selected = { bg = "none" },
                    tab_close = { bg = "none" },
                    close_button = { bg = "none" },
                    close_button_visible = { bg = "none" },
                    close_button_selected = { bg = "none" },
                    modified = { bg = "none" },
                    modified_visible = { bg = "none" },
                    modified_selected = { bg = "none" },
                    indicator_selected = { fg = primary, bg = "none" },
                },
            }
        end,
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

    -- Which-Key
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
