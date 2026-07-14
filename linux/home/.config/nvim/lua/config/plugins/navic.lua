local default_colors = require('ref.default_colors')
local icons = vim.tbl_map(function(icon) return icon .. ' ' end, require('ref.icons').kinds)

vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
        for k, v in pairs(default_colors.kinds) do
            vim.api.nvim_set_hl(0, ('NavicIcons' .. k), { default = true, fg = v })
        end
    end,
    group = vim.api.nvim_create_augroup('NavicDefaultColors', { clear = true }),
})

return {
    'SmiteshP/nvim-navic',
    dependencies = { 'neovim/nvim-lspconfig' },
    event = 'LspAttach',
    opts = {
        icons = icons,
        highlight = true,
        lsp = {
            auto_attach = true,
        },
    },
}
