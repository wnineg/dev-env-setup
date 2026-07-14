return {
    'mrjones2014/smart-splits.nvim',
    lazy = false,
    config = function()
        local ss = require('smart-splits')
        vim.keymap.set({'n', 'v', 't'}, '<A-h>', ss.move_cursor_left)
        vim.keymap.set({'n', 'v', 't'}, '<A-j>', ss.move_cursor_down)
        vim.keymap.set({'n', 'v', 't'}, '<A-k>', ss.move_cursor_up)
        vim.keymap.set({'n', 'v', 't'}, '<A-l>', ss.move_cursor_right)
    end,
}
