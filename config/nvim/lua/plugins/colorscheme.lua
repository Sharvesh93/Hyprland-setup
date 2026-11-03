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
                local ok, matugen = pcall(require, "generated.colors")
                if ok and matugen then
                    if matugen.primary then colors.blue = matugen.primary end
                    if matugen.secondary then colors.cyan = matugen.secondary end
                    if matugen.tertiary then colors.magenta = matugen.tertiary end
                    if matugen.error then colors.red = matugen.error end
                    if matugen.text then colors.fg = matugen.text end
                end
            end,
            on_highlights = function(hl, colors)
                local ok, matugen = pcall(require, "generated.colors")
                local border_col = (ok and matugen.outline_variant) or colors.border_highlight or colors.blue
                local primary_col = (ok and matugen.primary) or colors.blue
                local yellow_col = (ok and matugen.primary_container) or colors.yellow or "#e0af68"

                hl.Normal = { bg = "none" }
                hl.NormalNC = { bg = "none" }
                hl.NormalFloat = { bg = "none" }
                hl.FloatBorder = { bg = "none", fg = border_col }
                hl.FloatTitle = { bg = "none", fg = primary_col, bold = true }
                hl.SignColumn = { bg = "none" }
                hl.LineNr = { bg = "none" }
                hl.CursorLineNr = { bg = "none", fg = primary_col, bold = true }
                hl.EndOfBuffer = { bg = "none" }
                hl.WinSeparator = { bg = "none", fg = border_col }
                hl.VertSplit = { bg = "none", fg = border_col }

                -- Neo-Tree File Explorer Transparency
                hl.NeoTreeNormal = { bg = "none" }
                hl.NeoTreeNormalNC = { bg = "none" }
                hl.NeoTreeEndOfBuffer = { bg = "none" }
                hl.NeoTreeWinSeparator = { bg = "none", fg = border_col }
                hl.NeoTreeCursorLine = { bg = "none" }

                -- Telescope Transparency
                hl.TelescopeNormal = { bg = "none" }
                hl.TelescopeBorder = { bg = "none", fg = border_col }
                hl.TelescopePromptNormal = { bg = "none" }
                hl.TelescopePromptBorder = { bg = "none", fg = primary_col }
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
