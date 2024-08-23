return {
    'echasnovski/mini.files',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
        { '<Leader>f', function() require('mini.files').open() end },
    },
    config = true,
}
