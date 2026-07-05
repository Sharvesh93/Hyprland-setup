vim.cmd("packadd catppuccin")
local colors = require("generated.colors")

require("catppuccin").setup({
    flavour = "macchiato",

    color_overrides = {
        macchiato = {
            base = colors.background,
            mantle = colors.surface,
            crust = colors.surface,

            text = colors.text,

            blue = colors.primary,
            sapphire = colors.secondary,
            lavender = colors.tertiary,

            red = colors.error,
        },
    },
})

vim.cmd.colorscheme("catppuccin")
