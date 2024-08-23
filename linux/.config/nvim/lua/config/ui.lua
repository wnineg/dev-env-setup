-- Main Startup Theme
vim.cmd.colorscheme 'solarized8'

vim.api.nvim_set_hl(0, 'Pmenu', { ctermfg = 247, blend = 20 })

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({ higroup = 'Yanked', timeout = 200 })
    end,
    group = vim.api.nvim_create_augroup('highlightYank', { clear = true }),
})
vim.api.nvim_set_hl(0, 'Yanked', { bg = 'Red' })

local icons = require('ref.icons').diagnostics
vim.diagnostic.config({
    severity_sort = true,
    --update_in_insert = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = icons.error,
            [vim.diagnostic.severity.WARN] = icons.warn,
            [vim.diagnostic.severity.INFO] = icons.info,
            [vim.diagnostic.severity.HINT] = icons.hint,
        }
    },
    virtual_text = {
        prefix = '⬤',
    },
})
