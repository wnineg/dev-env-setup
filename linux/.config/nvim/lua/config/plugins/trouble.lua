local icons = require('ref.icons').kinds

return {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    keys = {
        {
            '<leader>xx',
            '<cmd>Trouble diagnostics toggle<cr>',
            desc = 'Diagnostics (Trouble)',
        },
        {
            '<leader>xX',
            '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
            desc = 'Buffer Diagnostics (Trouble)',
        },
        {
            '<leader>ss',
            '<cmd>Trouble symbols toggle<cr>',
            desc = 'Symbols (Trouble)',
        },
        {
            '<leader>sr',
            '<cmd>Trouble lsp toggle follow=false<cr>',
            desc = 'LSP Definitions / references / ... (Trouble)',
        },
        {
            '<leader>xL',
            '<cmd>Trouble loclist toggle<cr>',
            desc = 'Location List (Trouble)',
        },
        {
            '<leader>xQ',
            '<cmd>Trouble qflist toggle<cr>',
            desc = 'Quickfix List (Trouble)',
        },
    },
    opts = {
        multiline = false,
        warn_no_results = false,
        open_no_results = true,
        icons = {
            kinds = icons,
        },
    },
}
