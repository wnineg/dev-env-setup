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
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            vim.lsp.config('*', {
                capabilities = capabilities,
            })
        end,
    }
}
