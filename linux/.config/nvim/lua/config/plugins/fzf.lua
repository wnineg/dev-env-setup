return {
    'ibhagwan/fzf-lua',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { '<Leader>o', function() require('fzf-lua').files({ resume = true }) end },
        { '<Leader>b', function() require('fzf-lua').buffers() end },
        { '<Leader>g', function() require('fzf-lua').live_grep({ resume = true }) end },
    },
    cmd = 'FzfLua',
    opts = {
        winopts = {
            preview = {
                wrap = 'wrap',
            },
        },
        keymap = {
            builtin = {
                true,
                ['<C-f>'] = 'preview-page-down',
                ['<C-b>'] = 'preview-page-up',
            },
        },
    },
}
