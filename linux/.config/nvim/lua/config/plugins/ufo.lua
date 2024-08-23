return {
    'kevinhwang91/nvim-ufo',
    dependencies = {
        'kevinhwang91/promise-async',
        'neovim/nvim-lspconfig',
    },
    opts = {
        provider_selector = function()
            return { 'treesitter', 'indent' }
        end,
    },
}
