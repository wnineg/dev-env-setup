return {
    'RRethy/vim-illuminate',
    config = function(_, opts)
        local illuminate = require('illuminate')
        illuminate.configure(opts)

        vim.keymap.set('n', '<C-n>', function() illuminate.goto_next_reference(false) end)
        vim.keymap.set('n', '<C-p>', function() illuminate.goto_prev_reference(false) end)
    end,
}
