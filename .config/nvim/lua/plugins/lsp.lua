return {
    -- CMP
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        -- version = '1.*',
        build = 'cargo build --release',
        opts = {
            keymap = { preset = 'default' },
            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },
            completion = { documentation = { auto_show = true } },
            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default", "cmdline", "omni" }
    },
    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'saghen/blink.cmp' },
            { 'mason-org/mason.nvim' },
            { 'mason-org/mason-lspconfig.nvim' },
            { 'mfussenegger/nvim-jdtls' },
        },
        config = function()
            local autoformat = true

            local capabilities = require('blink.cmp').get_lsp_capabilities()
            vim.lsp.config('*', {
                capabilities = capabilities,
                root_markers = { '.git' },
            })

            vim.api.nvim_create_augroup("lsp_augroup", { clear = true })

            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    -- if client and client:supports_method('textDocument/completion') then
                    --     vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
                    -- end

                    if autoformat and client and client:supports_method('textDocument/formatting') then
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                            end,
                        })
                    end

                    if client and client:supports_method('textDocument/inlayHint') then
                        vim.api.nvim_create_autocmd("InsertEnter", {
                            buffer = args.buf,
                            callback = function() vim.lsp.inlay_hint.enable(true) end,
                            group = "lsp_augroup",
                        })
                        vim.api.nvim_create_autocmd("InsertLeave", {
                            buffer = args.buf,
                            callback = function() vim.lsp.inlay_hint.enable(false) end,
                            group = "lsp_augroup",
                        })
                    end

                    local wk = require('which-key')
                    wk.add({
                        -- LSP actions
                        { "K",           function() vim.lsp.buf.hover() end,                                            desc = "Hover" },
                        { "gd",          function() vim.lsp.buf.definition() end,                                       desc = "Go to Definition" },
                        { "gD",          function() vim.lsp.buf.declaration() end,                                      desc = "Go to Declaration" },
                        { "gi",          function() vim.lsp.buf.implementation() end,                                   desc = "Go to Implementation" },
                        { "go",          function() vim.lsp.buf.type_definition() end,                                  desc = "Go to Type Definition" },
                        { "gr",          function() vim.lsp.buf.references() end,                                       desc = "Go to References" },
                        { "gs",          function() vim.lsp.buf.signature_help() end,                                   desc = "Signature help" },
                        { "<leader>vws", function() vim.lsp.buf.workspace_symbol() end,                                 desc = "Workspace symbol" },
                        { "<leader>vca", function() vim.lsp.buf.code_action() end,                                      desc = "View code actions" },
                        { "<leader>vrn", function() vim.lsp.buf.rename() end,                                           desc = "Rename" },
                        { "<leader>H",   function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, desc = "Toggle Inlay Hints" },
                        { "<leader>f",   function() vim.lsp.buf.format({ async = true }) end,                           desc = "Format" },
                        -- Diagnostics
                        { "<leader>vd",  function() vim.diagnostic.open_float() end,                                    desc = "Open diagnostic" },
                        -- { "[d",          function() vim.diagnostic.goto_prev() end,           desc = "Previous diagnostic" },
                        -- { "]d",          function() vim.diagnostic.goto_next() end,           desc = "Next diagnostic" },

                    })
                end,
                group = "lsp_augroup"
            })

            vim.api.nvim_create_autocmd('LspDetach', {
                callback = function(args)
                    -- Get the detaching client
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    -- Remove the autocommand to format the buffer on save, if it exists
                    vim.api.nvim_clear_autocmds({ group = "lsp_augroup", buffer = args.buf })
                end,
                group = "lsp_augroup"
            })

            vim.lsp.set_log_level("WARN")

            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'lua_ls',
                    "vimls",
                    'clangd',
                    'jdtls',
                    'rust_analyzer',
                    'tinymist',
                },
            })

            vim.lsp.enable("ocamllsp")
            vim.lsp.enable("jdtls")
            vim.lsp.config("mojo-lsp-server", { cmd = { "mojo-lsp-server" }, filetypes = { "mojo" } })
            vim.lsp.enable("mojo-lsp-server")

            vim.diagnostic.config({
                virtual_lines = true
            })
        end
    }
}
