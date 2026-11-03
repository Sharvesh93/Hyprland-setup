-- Hyprland Look & Feel: Clean, Minimalist, Borderless
hl.config({
	general = {
		gaps_in = 3,
		gaps_out = 6,
		border_size = 0,
		layout = "dwindle",
	},

	decoration = {
		rounding = 8,
		rounding_power = 2,

		active_opacity = 0.98,
		inactive_opacity = 0.88,

		shadow = {
			enabled = false,
		},

		blur = {
			enabled = true,
			size = 6,
			passes = 3,
			new_optimizations = true,
			xray = false,
			vibrancy = 0.20,
			noise = 0.02,
		},
	},
})
