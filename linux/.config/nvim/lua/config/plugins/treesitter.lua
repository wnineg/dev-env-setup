return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
        ensure_installed = {
            'bash',
            'c',
            'git_config',
            'git_rebase',
            'gitattributes',
            'gitcommit',
            'gitignore',
            'json',
            'java',
            'javascript',
            'lua',
            'markdown',
            'markdown_inline',
            'python',
            'regex',
            'typescript',
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
