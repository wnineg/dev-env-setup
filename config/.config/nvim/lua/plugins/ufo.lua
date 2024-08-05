return {
    'kevinhwang91/nvim-ufo',
    dependencies = {
        'kevinhwang91/promise-async',
        'neovim/nvim-lspconfig',
    },
    lazy = false,
    opts = {
        provider_selector = function()
            return { 'treesitter', 'indent' }
        end,
    },
}
