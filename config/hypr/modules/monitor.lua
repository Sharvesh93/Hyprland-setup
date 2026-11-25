-- "preferred" works on every monitor; forcing 1920x1080@144 on all outputs
-- breaks laptops and any display with a different native resolution.
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})
