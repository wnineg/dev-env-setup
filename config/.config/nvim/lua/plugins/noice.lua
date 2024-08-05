return {
    'folke/noice.nvim',
    dependencies = {
        'MunifTanjim/nui.nvim',
        'rcarriga/nvim-notify',
        'nvim-treesitter/nvim-treesitter',
    },
    opts = {
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                ['vim.lsp.util.stylize_markdown'] = true,
                ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
            },
        },
        messages = { enabled = false },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = false, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true, -- add a border to hover docs and signature help
        },
    },
    config = function(_, opts)
        require('noice').setup(opts)

        -- hover scrolling
        local noice_lsp = require('noice.lsp')
        vim.keymap.set({ 'n', 'i', 's' }, '<C-f>', function()
            if not noice_lsp.scroll(4) then
                return '<C-f>'
            end
        end, { silent = true, expr = true })
        vim.keymap.set({ 'n', 'i', 's' }, '<C-b>', function()
            if not noice_lsp.scroll(-4) then
                return '<C-b>'
            end
        end, { silent = true, expr = true })

        vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorder', { link = 'DiagnosticInfo' })
        vim.api.nvim_set_hl(0, 'NoiceCmdlineIcon', { link = 'DiagnosticInfo' })
        vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupTitleSearch', { link = 'DiagnosticInfo' })
        vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorderSearch', { link = 'DiagnosticInfo' })
        vim.api.nvim_set_hl(0, 'NoiceCmdlineIconSearch', { link = 'DiagnosticInfo' })
    end,
}
