return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "night",
            transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
                comments = { italic = true },
                keywords = { italic = true },
            },
            on_colors = function(colors)
                -- Optionally integrate Matugen generated accent colors if available
                local ok, matugen = pcall(require, "generated.colors")
                if ok and matugen then
                    if matugen.primary then colors.blue = matugen.primary end
                    if matugen.secondary then colors.cyan = matugen.secondary end
                    if matugen.tertiary then colors.magenta = matugen.tertiary end
                    if matugen.error then colors.red = matugen.error end
                end
            end,
            on_highlights = function(hl, colors)
                hl.Normal = { bg = "none" }
                hl.NormalNC = { bg = "none" }
                hl.NormalFloat = { bg = "none" }
                hl.FloatBorder = { bg = "none", fg = colors.border_highlight or colors.blue }
                hl.SignColumn = { bg = "none" }
                hl.LineNr = { bg = "none" }
                hl.CursorLineNr = { bg = "none", fg = colors.yellow or "#e0af68", bold = true }
                hl.EndOfBuffer = { bg = "none" }
            end,
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight-night")
            -- Re-apply full transparency
            require("config.transparency").apply()
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
        opts = {
            flavour = "mocha",
            transparent_background = true,
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = false,
                mini = false,
                telescope = { enabled = true, style = "nvchad" },
                which_key = true,
            },
        },
    },
}
