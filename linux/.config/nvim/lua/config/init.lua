if vim.fn.has('wsl') == 1 then
    -- :h clipboard-wsl
    vim.g.clipboard = {
        name = 'WslClipboard',
        copy = {
            ['+'] = 'clip.exe',
            ['*'] = 'clip.exe',
        },
        paste = {
            ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = false,
    }
end

-- Jump to the last edited position on file open
-- :h restore-cursor
local restore_cursor_group = vim.api.nvim_create_augroup('RestoreCursor', { clear = true })
local cursor_reset_types = { 'gitcommit', 'gitrebase', 'xxd' }
vim.api.nvim_create_autocmd('BufReadPre', {
    callback = function()
        vim.api.nvim_create_autocmd('BufWinEnter', {
            callback = function()
                if vim.tbl_contains(cursor_reset_types, vim.bo.filetype) then return end
                local last_pos = vim.api.nvim_buf_get_mark(0, '"')
                if last_pos[1] == 0 or last_pos[1] > vim.api.nvim_buf_line_count(0) then return end
                vim.api.nvim_win_set_cursor(0, last_pos)
            end,
            buffer = 0,
            once = true,
            group = restore_cursor_group,
        })
    end,
    group = restore_cursor_group,
})
