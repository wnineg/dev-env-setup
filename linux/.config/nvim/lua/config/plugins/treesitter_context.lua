return {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'VeryLazy',
    config = function(_, opts)
        require('treesitter-context').setup(opts)

        vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { underline = true, sp = 'Grey' })
        vim.api.nvim_set_hl(0, 'TreesitterContextLineNumberBottom', { underline = true, sp = 'Grey' })
    end,
}
