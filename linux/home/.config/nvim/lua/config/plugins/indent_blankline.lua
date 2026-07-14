vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
        local fold_fg = vim.api.nvim_get_hl(0, { name = 'FoldColumn' }).fg
        vim.api.nvim_set_hl(0, 'IblScope', { default = true, fg = fold_fg })
    end,
    group = vim.api.nvim_create_augroup('IndentBlanklineDefaultColors', { clear = true }),
})

return {
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    opts = {
        indent = {
            char = '▏',
        },
        scope = {
            show_exact_scope = true,
        },
    },
    config = function(_, opts)

        require('ibl').setup(opts)
    end,
}
