hl.config({
    dwindle = {
        preserve_split = true, 
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})

hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

-- Layer rules for Quickshell
hl.layer_rule({
    name = "quickshell-blur",
    match = { namespace = "quickshell" },
    blur = true,
})

-- Terminal window rules for blur and slight transparency
hl.window_rule({
    name = "kitty-blur",
    match = { class = "kitty" },
    opacity = "0.95 0.88",
})

hl.layer_rule({
     name = "rofi-popup",
     match =  {namespace = "rofi"},
     animation = "fade", 
     dim_around = true
})
