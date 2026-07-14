local git_group = vim.api.nvim_create_augroup("gitsetup_local", { clear = true })

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    group = git_group,
    buffer = 0,
    callback = function()
        -- Set local textwidth to 0 on line 1 (the title), otherwise 120
        if vim.fn.line('.') == 1 then
            vim.opt_local.textwidth = 0
        else
            vim.opt_local.textwidth = 120
        end
    end,
})
