return {
    'ibhagwan/fzf-lua',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { '<Leader>o', function() require('fzf-lua').files() end },
        { '<Leader>b', function() require('fzf-lua').buffers() end },
        { '<Leader>f', function() require('fzf-lua').live_grep() end },
    },
    cmd = 'FzfLua',
}
