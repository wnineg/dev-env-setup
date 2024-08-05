local icons = require('ref.icons').diagnostics

return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'SmiteshP/nvim-navic',
    },
    opts = {
        options = {
            theme = 'onedark',
        },
        winbar = {
            lualine_c = {
                {
                    'navic',
                    navic_opts = {
                        highlight = true,
                    },
                },
            },
        },
        sections = {
            lualine_a = {
                'mode',
                {
                    'v:hlsearch',
                    icon = '󱎸',
                    fmt = function()
                        return vim.v.hlsearch == 1 and '' or ''
                    end,
                },
                {
                    'wo:spell',
                    icon = '',
                    fmt = function()
                        return vim.wo.spell and '' or ''
                    end,
                },
            },
            lualine_b = {
                'branch',
                'diff',
                {
                    'diagnostics',
                    symbols = icons,
                },
            },
            lualine_c = {
                {
                    'filename',
                    path = 1,
                    symbols = {
                        newfile = '󰎔',
                        unnamed = '󰡯',
                        readonly = '󰌾',
                        modified = '󰏬',
                    },
                },
            },
        },
    },
}
