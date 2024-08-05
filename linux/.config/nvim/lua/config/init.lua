if vim.env.WSL_DISTRO_NAME then
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
        cache_enabled = false
    }
end

-- Jump to the last edited position on file open
-- :h restore-cursor
local restoreCursorGroup = vim.api.nvim_create_augroup('RestoreCursor', { clear = true })
vim.api.nvim_create_autocmd('BufReadPre', {
    callback = function()
        vim.api.nvim_create_autocmd('FileType', {
            callback = function()
                local lastPos = vim.api.nvim_buf_get_mark(0, '"')
                if lastPos == 0 then return end
                local type = vim.o.filetype
                local excludedTypes = { 'gitcommit', 'xxd', 'gitrebase' }
                if vim.tbl_contains(excludedTypes, type) then return end
                vim.api.nvim_win_set_cursor(0, lastPos)
            end,
            buffer = 0,
            once = true,
            group = restoreCursorGroup,
        })
    end,
    group = restoreCursorGroup,
})