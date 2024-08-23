local icons = require('ref.icons').diagnostics

---@param icon      string
---@param expr      string
---@param check_opt fun(): boolean
local function create_opt_comp(icon, expr, check_opt)
    return {
        expr,
        icon = icon,
        color = function()
            return { fg = (check_opt() and 'Black' or 'Grey') }
        end,
        fmt = function()
            return check_opt() and '' or ''
        end,
    }
end

local file_name_comp = {
    'filename',
    path = 1,
    symbols = {
        newfile = '󰎔',
        unnamed = '󰡯',
        readonly = '󰌾',
        modified = '󰏬',
    },
}

return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'SmiteshP/nvim-navic',
    },
    opts = {
        options = {
            disabled_filetypes = {
                statusline = {
                    'qf',
                    'trouble',
                },
            },
            theme = 'onedark',
            ignore_focus = {
                'dap-repl',
                'dapui_breakpoints',
                'dapui_console',
                'dapui_scopes',
                'dapui_stacks',
                'dapui_watches',
                'help',
            },
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
                create_opt_comp('󱎸', 'v:hlsearch', function() return vim.v.hlsearch == 1 end),
                create_opt_comp('󰖶', 'wo:wrap', function() return vim.wo.wrap end),
                create_opt_comp('', 'wo:spell', function() return vim.wo.spell end),
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
                file_name_comp,
            },
        },
        inactive_sections = {
            lualine_c = {
                file_name_comp,
            },
            lualine_y = {
                'progress',
            },
        },
    },
}
