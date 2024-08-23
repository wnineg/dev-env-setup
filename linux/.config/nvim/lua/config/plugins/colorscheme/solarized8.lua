return {
    'lifepillar/vim-solarized8',
    branch = 'neovim',
    lazy = false,
    priority = 1000,
    config = function()
        vim.api.nvim_create_autocmd('ColorScheme', {
            pattern = 'solarized8',
            callback = function()
                local line_nr_hl = vim.api.nvim_get_hl(0, { name = 'LineNr' })

                local nontext_fg = '#3d494e'

                local diagnostic_error = 'Red'
                local diagnostic_warn  = 'Orange'
                local diagnostic_info  = 'LightBlue'
                local diagnostic_hint  = 'LightGreen'

                vim.api.nvim_set_hl(0, 'NonText', { fg = nontext_fg })
                vim.api.nvim_set_hl(0, 'Folded', { bg = '#0F5A6F' })

                vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = line_nr_hl.bg, fg = '#ff966c' })
                vim.api.nvim_set_hl(0, 'ColorColumn', { link = 'CursorColumn', default = true })
                vim.api.nvim_set_hl(0, 'FoldColumn', { bg = line_nr_hl.bg, fg = 'White' })
                vim.api.nvim_set_hl(0, 'WinSeparator', { fg = nontext_fg })
                vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#002b36' })
                vim.api.nvim_set_hl(0, 'FloatBorder', { fg = nontext_fg })

                vim.api.nvim_set_hl(0, 'SpellBad', { undercurl = true, sp = '#6c71c4' })
                vim.api.nvim_set_hl(0, 'SpellCap', { undercurl = true, sp = '#6c71c4' })
                vim.api.nvim_set_hl(0, 'SpellRare', { undercurl = true, sp = '#2aa198' })
                vim.api.nvim_set_hl(0, 'SpellLocal', { undercurl = true, sp = '#b58900' })

                vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = diagnostic_error })
                vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = diagnostic_warn })
                vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = diagnostic_info })
                vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = diagnostic_hint })
                vim.api.nvim_set_hl(0, 'DiagnosticSignError', { bg = line_nr_hl.bg, fg = diagnostic_error })
                vim.api.nvim_set_hl(0, 'DiagnosticSignWarn', { bg = line_nr_hl.bg, fg = diagnostic_warn })
                vim.api.nvim_set_hl(0, 'DiagnosticSignInfo', { bg = line_nr_hl.bg, fg = diagnostic_info })
                vim.api.nvim_set_hl(0, 'DiagnosticSignHint', { bg = line_nr_hl.bg, fg = diagnostic_hint })

                vim.api.nvim_set_hl(0, 'TreesitterContext', { bg = '#002630' })
            end,
            group = vim.api.nvim_create_augroup('Solarized8Tuning', { clear = true }),
        })
    end,
}
