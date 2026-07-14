return {
    'nvim-mini/mini.files',
    version = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
        { '<Leader>f', function() require('mini.files').open() end },
    },
    opts = {
        mappings = {
            go_in = '',
            go_out = '',
        },
    },
    config = function(_, opts)
        require('mini.files').setup(opts)
    end,
}
