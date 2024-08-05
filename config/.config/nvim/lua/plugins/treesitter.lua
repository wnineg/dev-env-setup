return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
        ensure_installed = {
            'bash',
            'json',
            'java',
            'javascript',
            'lua',
            'markdown',
            'markdown_inline',
            'python',
            'regex',
            'vim',
            'vimdoc',
        },
        sync_install = true,
        auto_install = false,
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
    },
}
