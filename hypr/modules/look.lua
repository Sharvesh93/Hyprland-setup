hl.config({
    general = {
        gaps_in  = 4,
        gaps_out = 10,
        
        border_size = 1,
        col = {
            active_border   = { colors = {"rgba(b7bdf8ee)", "rgba(b7bdf8ee)"}, angle = 45 },
            inactive_border = "rgba(494d64aa)",
        },
        resize_on_border =false,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,
        active_opacity   = 1.0,

        inactive_opacity = 0.8,

        shadow = {
            enabled      = true,
            range        = 4,
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
