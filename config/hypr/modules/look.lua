local colors = require("themes.palette")
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 7,
        border_size = 0,
        col = {
            active_border   = colors.primary,
            inactive_border = colors.outline    
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding       = 16, 
        rounding_power = 2,
        active_opacity   = 0.98, 
        inactive_opacity = 0.94,

        shadow = {
            enabled      = true,
            range        = 20, 
            render_power = 3,
            color        = 0x66000000, 
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

    -- Add this block for Kitty-specific opacity (Active and Inactive)
    windowrulev2 = {
        "opacity 1.0 0.95, class:^(kitty)$"
    },
})
