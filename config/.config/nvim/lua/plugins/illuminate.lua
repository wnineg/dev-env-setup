return {
    'RRethy/vim-illuminate',
    lazy = false,
    keys = {
        { '<C-n>', function() require('illuminate').goto_next_reference(false) end },
        { '<C-p>', function() require('illuminate').goto_prev_reference(false) end },
    },
    config = function()
        require('illuminate').configure({})
    end,
}
