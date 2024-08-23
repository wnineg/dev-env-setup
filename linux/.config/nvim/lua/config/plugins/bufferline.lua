local icons = require('ref.icons').diagnostics

return {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        options = {
            show_buffer_close_icons = false,
            diagnostics = 'nvim_lsp',
            diagnostics_indicator = function(count, level)
                local icon = level:match('error') and icons.error or icons.warn
                return ' ' .. icon .. ' ' .. count
            end,
        },
        highlights = {
            fill = { bg = '#002630' },
        },
    },
    config = function(_, opts)
        require('bufferline').setup(opts)

        vim.keymap.set('n', 'gb', '<Cmd>BufferLinePick<CR>')
    end,
}
