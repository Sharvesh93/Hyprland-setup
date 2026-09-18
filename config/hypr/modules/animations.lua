-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/

hl.curve("easeOutQuint",    { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("easeInOutCubic",  { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",          { type = "bezier", points = { {0, 0},       {1, 1} } })
hl.curve("almostLinear",    { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} } })
hl.curve("quick",           { type = "bezier", points = { {0.15, 0},    {0.1, 1} } })
hl.curve("easeInOutQuart",  { type = "bezier", points = { {0.76, 0},    {0.24, 1} } })

-- Smooth linear fade for the Ghost effect
hl.curve("smoothFade", { type = "bezier", points = { {0.5, 0}, {0.5, 1} } })

hl.animation({ leaf = "global",         enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",         enabled = true, speed = 2.5,  bezier = "smoothFade" })
hl.animation({ leaf = "windows",        enabled = true, speed = 2.5,  bezier = "smoothFade" })

-- Replaced "fade" with "popin 100%" to fix the error while keeping the ghost effect
hl.animation({ leaf = "windowsIn",      enabled = true, speed = 2.5,  bezier = "smoothFade", style = "popin 100%" })
hl.animation({ leaf = "windowsOut",     enabled = true, speed = 2.5,  bezier = "smoothFade", style = "popin 100%" })

hl.animation({ leaf = "fadeIn",         enabled = true, speed = 2.5,  bezier = "smoothFade" })
hl.animation({ leaf = "fadeOut",        enabled = true, speed = 2.5,  bezier = "smoothFade" })
hl.animation({ leaf = "fade",           enabled = true, speed = 2.5,  bezier = "smoothFade" })
hl.animation({ leaf = "layers",         enabled = true, speed = 2.5,  bezier = "smoothFade" })
hl.animation({ leaf = "layersIn",       enabled = true, speed = 2.5,  bezier = "smoothFade", style = "fade" })
hl.animation({ leaf = "layersOut",      enabled = true, speed = 2.5,  bezier = "smoothFade", style = "fade" })
hl.animation({ leaf = "fadeLayersIn",   enabled = true, speed = 2.5,  bezier = "smoothFade" })
hl.animation({ leaf = "fadeLayersOut",  enabled = true, speed = 2.5,  bezier = "smoothFade" })
hl.animation({ leaf = "workspaces",     enabled = true, speed = 2.5,  bezier = "smoothFade", style = "fade" })
hl.animation({ leaf = "workspacesIn",   enabled = true, speed = 2.5,  bezier = "smoothFade", style = "fade" })
hl.animation({ leaf = "workspacesOut",  enabled = true, speed = 2.5,  bezier = "smoothFade", style = "fade" })
hl.animation({ leaf = "zoomFactor",     enabled = true, speed = 2.5,  bezier = "smoothFade" })
