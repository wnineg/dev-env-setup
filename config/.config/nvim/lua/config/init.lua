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
vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
        local lastPos = vim.api.nvim_buf_get_mark(0, '"')
        if lastPos == 0 then return end
        local type = vim.opt.filetype:get()
        local excludedTypes = { 'gitcommit', 'xxd', 'gitrebase' }
        local excluded = false
        for i = 1, #excludedTypes do
            if type == excludedTypes[i] then
                excluded = true
                break
            end
        end
        if excluded then return end
        vim.api.nvim_win_set_cursor(0, lastPos)
    end,
    group = vim.api.nvim_create_augroup('vimStartup', { clear = true }),
})
