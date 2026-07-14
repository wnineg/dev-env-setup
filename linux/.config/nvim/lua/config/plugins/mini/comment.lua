return {
    'nvim-mini/mini.comment',
    version = false,
    keys = { { '<C-_>', mode = { 'n', 'v' } } },
    opts = {
        options = {
            start_of_line = true,
            pad_comment_parts = false,
        },
        mappings = {
            comment = nil,
            comment_line = '<C-_>',
            comment_visual = '<C-_>',
            textobject = nil,
        },
    },
    config = function(_, opts)
        require('mini.comment').setup(opts)
    end,
}
