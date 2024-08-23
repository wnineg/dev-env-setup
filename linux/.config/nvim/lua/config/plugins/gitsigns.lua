vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
        vim.api.nvim_set_hl(0, 'GitSignsAdd', { default = true, link = 'DiffAdd' })
        vim.api.nvim_set_hl(0, 'GitSignsChange', { default = true, link = 'DiffChange' })
        vim.api.nvim_set_hl(0, 'GitSignsDelete', { default = true, link = 'DiffDelete' })
        -- Harmonizes the bg colors of the staged signs
        local sign_col_bg = vim.api.nvim_get_hl(0, { name = 'SignColumn' }).bg
        for _, suffix in pairs({ 'Add', 'Change', 'Delete', 'Changedelete', 'Topdelete' }) do
            local staged_hl_name = 'GitSignsStaged' .. suffix
            local fg = vim.api.nvim_get_hl(0, { name = staged_hl_name }).fg
            vim.api.nvim_set_hl(0, staged_hl_name, { default = true, bg = sign_col_bg, fg = fg })
        end
    end,
    group = vim.api.nvim_create_augroup('GitSignsDefaultColors', { clear = true }),
})

return {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {
        current_line_blame_formatter = '<abbrev_sha> <author> [<author_time:%R>] - <summary>',
        on_attach = function(bufnr)
            local gitsigns = require('gitsigns')

            local function map(from, modes, to, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(modes, from, to, opts)
            end

            map(']c', 'n', function()
                if vim.wo.diff then
                    vim.cmd.normal({ ']c', bang = true })
                else
                    gitsigns.nav_hunk('next')
                end
            end)

            map('[c', 'n', function()
                if vim.wo.diff then
                    vim.cmd.normal({ '[c', bang = true })
                else
                    gitsigns.nav_hunk('prev')
                end
            end)

            map('<leader>hs', 'n', gitsigns.stage_hunk)
            map('<leader>hr', 'n', gitsigns.reset_hunk)
            map('<leader>hs', 'v', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
            map('<leader>hr', 'v', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
            map('<leader>hS', 'n', gitsigns.stage_buffer)
            map('<leader>hu', 'n', gitsigns.undo_stage_hunk)
            map('<leader>hR', 'n', gitsigns.reset_buffer)
            map('<leader>hp', 'n', gitsigns.preview_hunk)
            map('<leader>hb', 'n', function() gitsigns.blame_line{ full = true } end)
            map('<leader>tb', 'n', gitsigns.toggle_current_line_blame)
            map('<leader>hd', 'n', gitsigns.diffthis)
            map('<leader>hD', 'n', function() gitsigns.diffthis('~') end)
            map('<leader>td', 'n', gitsigns.toggle_deleted)
        end,
    },
}
