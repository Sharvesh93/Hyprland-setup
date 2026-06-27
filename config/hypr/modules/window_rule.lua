
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

hl.layer_rule({
     name = "rofi-popup",
     match =  {namespace = "rofi"},
     animation = "fade", 
     dim_around = true
})

hl.layer_rule({
     name = "Notification",
     match = { namespace = "swaync-control-center"},
     animation = "slide top"
})
