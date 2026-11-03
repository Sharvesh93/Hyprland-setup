return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall", "TSInstallSync" },
        opts = {
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "css",
                "diff",
                "html",
                "javascript",
                "json",
                "lua",
                "markdown",
                "python",
                "regex",
                "toml",
                "vim",
                "vimdoc",
                "yaml",
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        },
        config = function(_, opts)
            local ok, configs = pcall(require, "nvim-treesitter.configs")
            if ok and configs then
                configs.setup(opts)
            end
        end,
    },
}
