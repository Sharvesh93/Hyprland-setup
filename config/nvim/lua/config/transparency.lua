local M = {}

-- Comprehensive list of highlight groups to make transparent
M.transparent_groups = {
    -- Base Editor
    "Normal",
    "NormalNC",
    "NormalSB",
    "EndOfBuffer",
    "SignColumn",
    "LineNr",
    "CursorLineNr",
    "FoldColumn",
    "Folded",
    "WinSeparator",
    "VertSplit",
    "CursorLine",

    -- Floating Windows & Popups
    "NormalFloat",
    "FloatBorder",
    "FloatTitle",

    -- Statusline & Tabline Base
    "StatusLine",
    "StatusLineNC",
    "TabLine",
    "TabLineFill",
    "TabLineSel",

    -- Telescope UI
    "TelescopeNormal",
    "TelescopeBorder",
    "TelescopePromptNormal",
    "TelescopePromptBorder",
    "TelescopePromptTitle",
    "TelescopePromptPrefix",
    "TelescopeResultsNormal",
    "TelescopeResultsBorder",
    "TelescopeResultsTitle",
    "TelescopePreviewNormal",
    "TelescopePreviewBorder",
    "TelescopePreviewTitle",
    "TelescopeSelection",

    -- Which-Key
    "WhichKey",
    "WhichKeyFloat",
    "WhichKeyBorder",
    "WhichKeyNormal",
    "WhichKeyTitle",
    "WhichKeyGroup",
    "WhichKeyDesc",
    "WhichKeySeparator",

    -- Lazy.nvim & Mason UI
    "LazyNormal",
    "LazyBorder",
    "MasonNormal",
    "MasonBorder",

    -- LSP & Diagnostics
    "DiagnosticFloatingError",
    "DiagnosticFloatingWarn",
    "DiagnosticFloatingInfo",
    "DiagnosticFloatingHint",
    "LspInfoBorder",
    "LspFloatWinNormal",
    "LspFloatWinBorder",

    -- Completion Menu (nvim-cmp)
    "Pmenu",
    "PmenuSbar",
    "PmenuThumb",
    "CmpItemAbbr",
    "CmpItemAbbrDeprecated",
    "CmpItemAbbrMatch",
    "CmpItemAbbrMatchFuzzy",
    "CmpItemKind",
    "CmpItemMenu",

    -- Neo-Tree File Explorer
    "NeoTreeNormal",
    "NeoTreeNormalNC",
    "NeoTreeEndOfBuffer",
    "NeoTreeWinSeparator",
    "NeoTreeCursorLine",

    -- GitSigns
    "GitSignsAdd",
    "GitSignsChange",
    "GitSignsDelete",

    -- Fidget / Notifications
    "FidgetTitle",
    "FidgetTask",
}

function M.apply()
    for _, group in ipairs(M.transparent_groups) do
        local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
        if ok and hl then
            hl.bg = "none"
            hl.ctermbg = "none"
            vim.api.nvim_set_hl(0, group, hl)
        else
            vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
        end
    end

    -- Customize FloatBorder with a subtle, clean outline matching Hyprland aesthetics
    local border_color = "#3f484a"
    local pcall_matugen, matugen = pcall(require, "generated.colors")
    if pcall_matugen and matugen and matugen.outline_variant then
        border_color = matugen.outline_variant
    end
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = border_color, bg = "none" })
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = border_color, bg = "none" })
end

function M.setup()
    -- Apply immediately
    M.apply()

    -- Re-apply on ColorScheme changes so no theme or plugin overrides it
    local group = vim.api.nvim_create_augroup("TransparentBackground", { clear = true })
    vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter", "UIEnter" }, {
        group = group,
        callback = function()
            M.apply()
        end,
    })
end

return M
