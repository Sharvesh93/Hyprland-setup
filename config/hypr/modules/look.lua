local colors = require("themes.palette")
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 7,
        border_size = 1,
        col = {
            active_border   = colors.primary,
            inactive_border = colors.outline    
        },
        resize_on_border =false,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding       = 6,
        rounding_power = 1,
        active_opacity   = 0.95,

        inactive_opacity = 0.8,

        shadow = {
            enabled      = true,
            range        = 8,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
            size      = 8,
            passes    = 3,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})
