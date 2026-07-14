return {
    's1n7ax/nvim-window-picker',
    name = 'window-picker',
    event = 'VeryLazy',
    version = '2.*',
    keys = {
        {
            "<leader>w",
            function()
                local windows = vim.api.nvim_tabpage_list_wins(0)
                local valid_win_count = 0
                for _, win in ipairs(windows) do
                    local config = vim.api.nvim_win_get_config(win)
                    -- Ignore floating windows
                    if config.relative == "" then
                        valid_win_count = valid_win_count + 1
                        if valid_win_count > 1 then break end
                    end
                end
                if valid_win_count <= 1 then
                    return
                end

                local wid = require('window-picker').pick_window()
                if wid then
                    vim.api.nvim_set_current_win(wid)
                end
            end,
            mode = { 'n', 'v', 'c' }
        },
    },
    opts = {
        hint = 'floating-big-letter',
        show_prompt = false,
        filter_rules = {
            autoselect_one = false,
        },
    },
}
