return {
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'williamboman/mason.nvim',
        },
        lazy = true,
        opts = {
            ensure_installed = {
                'clangd',
                'lua_ls',
                'pylsp',
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            'hrsh7th/cmp-nvim-lsp',
        },
        event = 'VeryLazy',
        config = function()
            local lspconfig = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lsp_opts = {
                capabilities = capabilities,
            }

            lspconfig.pylsp.setup(lsp_opts)
            lspconfig.lua_ls.setup(lsp_opts)
            lspconfig.clangd.setup(lsp_opts)
        end,
    }
}
