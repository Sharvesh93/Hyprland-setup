vim.pack.add({
    {
        src = "https://github.com/catppuccin/nvim",
        name = "catppuccin",
    },
})

require("catppuccin").setup({

    flavour = "macchiato",

    transparent_background = false,

    no_italic = true,

    color_overrides = {
        macchiato = {
            base = "#0A1024",
            mantle = "#060A18",
            crust = "#02040C",

            surface0 = "#111A36",
            surface1 = "#172753",
            surface2 = "#223A68",

            text = "#E3E9FF",

            blue = "#7096FF",
            lavender = "#88ABFF",
        },
    },
})

vim.cmd.colorscheme("catppuccin")
