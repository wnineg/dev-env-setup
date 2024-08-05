return {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
        indent = {
            char = '▏',
        },
        scope = {
            show_exact_scope = true,
            highlight = 'ScopeGuide',
        },
    },
    config = function(_, opts)
        vim.api.nvim_set_hl(0, 'ScopeGuide', { bold = true, fg = 'White' })

        require('ibl').setup(opts)
    end,
}
