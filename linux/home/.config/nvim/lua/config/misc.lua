vim.api.nvim_set_hl(0, 'Pmenu', { ctermfg = 247, blend = 20 })

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({ higroup = 'Yanked', timeout = 200 })
    end,
    group = vim.api.nvim_create_augroup('HighlightYank', { clear = true }),
})
vim.api.nvim_set_hl(0, 'Yanked', { bg = 'Red' })
