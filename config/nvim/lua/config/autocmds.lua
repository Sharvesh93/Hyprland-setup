local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local general_group = augroup("GeneralSettings", { clear = true })

-- Highlight on yank
autocmd("TextYankPost", {
    group = general_group,
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
    end,
    desc = "Highlight text on yank",
})

-- Resize splits if window is resized
autocmd("VimResized", {
    group = general_group,
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
    desc = "Auto-resize splits on terminal resize",
})

-- Close certain filetypes with <q>
autocmd("FileType", {
    group = general_group,
    pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
        "man",
        "notify",
        "qf",
        "query",
        "checkhealth",
        "gitsigns.blame",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
    desc = "Close utility buffers with q",
})

-- Auto-create missing parent directories when saving a file
autocmd("BufWritePre", {
    group = general_group,
    callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
    desc = "Create missing parent directories on save",
})
