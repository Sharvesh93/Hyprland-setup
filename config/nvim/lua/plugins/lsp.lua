return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
            {
                "j-hui/fidget.nvim",
                opts = {
                    notification = {
                        window = { winblend = 0 },
                    },
                },
            },
        },
        config = function()
            -- Diagnostics Display Configuration
            local signs = {
                Error = "󰅚 ",
                Warn = "󰀪 ",
                Info = "󰋽 ",
                Hint = "󰌶 ",
            }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            vim.diagnostic.config({
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    prefix = "●",
                    spacing = 4,
                },
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })

            -- Floating Windows Border Defaults
            local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
            function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
                opts = opts or {}
                opts.border = opts.border or "rounded"
                return orig_util_open_floating_preview(contents, syntax, opts, ...)
            end

            -- LSP Capabilities with CMP support
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            if cmp_ok then
                capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
            end

            -- Attach Keymaps via modern LspAttach Autocmd
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
                callback = function(event)
                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
                    map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
                    map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
                    map("n", "gr", "<cmd>Telescope lsp_references<cr>", "Find References")
                    map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
                    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
                    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
                    map("n", "<leader>ld", vim.diagnostic.open_float, "Line Diagnostics")
                    map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
                    map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
                    map("n", "<leader>fm", function() vim.lsp.buf.format({ async = true }) end, "Format Document")
                end,
            })

            -- Mason Setup
            require("mason").setup({
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            local servers = {
                "pyright",       -- Python
                "clangd",        -- C / C++
                "jdtls",         -- Java
                "ts_ls",         -- JavaScript / TypeScript
                "html",          -- HTML
                "cssls",         -- CSS
                "jsonls",        -- JSON
                "yamlls",        -- YAML
                "bashls",        -- Bash
                "lua_ls",        -- Lua
                "rust_analyzer", -- Rust
                "sqlls",         -- SQL
            }

            local mason_lspconfig = require("mason-lspconfig")
            mason_lspconfig.setup({
                ensure_installed = servers,
                automatic_installation = true,
            })

            -- Configure and enable servers using Neovim native vim.lsp.config
            for _, server in ipairs(servers) do
                local opts = {
                    capabilities = capabilities,
                }

                if server == "lua_ls" then
                    opts.settings = {
                        Lua = {
                            runtime = { version = "LuaJIT" },
                            diagnostics = { globals = { "vim" } },
                            workspace = {
                                checkThirdParty = false,
                                library = {
                                    vim.env.VIMRUNTIME,
                                    "${3rd}/luv/library",
                                },
                            },
                            telemetry = { enable = false },
                        },
                    }
                elseif server == "jsonls" then
                    opts.settings = {
                        json = {
                            validate = { enable = true },
                        },
                    }
                end

                if vim.lsp.config then
                    vim.lsp.config(server, opts)
                    vim.lsp.enable(server)
                else
                    require("lspconfig")[server].setup(opts)
                end
            end
        end,
    },
}
