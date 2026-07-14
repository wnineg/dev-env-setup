return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local ts = require('nvim-treesitter')
        local ensure_installed = {
            'bash',
            'c',
            'cpp',
            'css',
            'git_config',
            'git_rebase',
            'gitattributes',
            'gitcommit',
            'gitignore',
            'html',
            'json',
            'java',
            'javascript',
            'lua',
            'make',
            'markdown',
            'markdown_inline',
            'python',
            'regex',
            'typescript',
            'vim',
            'vimdoc',
        }

        for _, lang in pairs(ensure_installed) do
            ts.install(lang)

            for _, ft in pairs(vim.treesitter.language.get_filetypes(lang)) do
                vim.api.nvim_create_autocmd("FileType", {
                    pattern = ft,
                    callback = function()
                        vim.treesitter.start()
                        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                        vim.wo[0][0].foldmethod = 'expr'
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end,
                })
            end
        end
    end
}
