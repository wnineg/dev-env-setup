local default_colors = require('ref.default_colors')
vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
        vim.api.nvim_set_hl(0, 'CmpItemAbbr', { default = true, fg = 'Grey' })
        vim.api.nvim_set_hl(0, 'CmpItemKind', { default = true, fg = '#2281c2' })
        vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', {
            default = true,
            strikethrough = true,
            fg = '#808080',
        })
        vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { default = true, fg = '#569cd6' })
        vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { default = true, link = 'CmpItemAbbrMatch' })

        for k, v in pairs(default_colors.kinds) do
            local hl_name = 'CmpItemKind' .. k
            vim.api.nvim_set_hl(0, hl_name, { default = true, fg = v })
        end
    end,
    group = vim.api.nvim_create_augroup('CmpDefaultColors', { clear = true }),
})

local function create_keymap(cmp)
    return {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<ESC>'] = cmp.mapping.abort(),
        ['<TAB>'] = cmp.mapping.confirm({ select = true }),
        ['<C-q>'] = function()
            if cmp.visible_docs() then
                cmp.close_docs()
            else
                cmp.open_docs()
            end
        end,
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4)
    }
end

return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            {
                'hrsh7th/cmp-nvim-lsp',
                dependencies = { 'neovim/nvim-lspconfig' },
            },
            {
                'saadparwaiz1/cmp_luasnip',
                dependencies = { 'L3MON4D3/LuaSnip' },
            },
            'hrsh7th/cmp-buffer',
        },
        event = 'InsertEnter',
        config = function()
            local icons = require('ref.icons').kinds
            local cmp = require('cmp')

            vim.api.nvim_create_autocmd('User', {
                pattern = 'LuasnipPreExpand',
                callback = function()
                    -- get event-parameters from `session`.
                    local snippet = require('luasnip').session.event_node
                    local expand_position =
                    require('luasnip').session.event_args.expand_pos

                    print(string.format('expanding snippet %s at %s:%s',
                    table.concat(snippet:get_docstring(), '\n'),
                    expand_position[1],
                    expand_position[2]
                    ))
                end
            })

            cmp.setup({
                formatting = {
                    format = function(_, vim_item)
                        if not (vim_item and vim_item.kind) then return vim_item end
                        local icon = icons[vim_item.kind]
                        if not icon then return vim_item end
                        vim_item.kind = icon .. '  ' .. vim_item.kind
                        return vim_item
                    end,
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = {
                        border = 'rounded',
                        scrolloff = 1,
                    },
                    documentation = {
                        border = 'rounded',
                        scrolloff = 1,
                    }
                },
                mapping = create_keymap(cmp),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                }),
                experimental = {
                    --ghost_text = { hl_group = 'CmpGhostText' }
                    ghost_text = true
                }
            })
        end,
    },
    {
        'hrsh7th/cmp-cmdline',
        dependencies = {
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'dmitmel/cmp-cmdline-history',
        },
        event = 'CmdlineEnter',
        config = function()
            local cmp = require('cmp')

            local keymap = {}
            for k, v in pairs(create_keymap(cmp)) do
                keymap[k] = { c = v }
            end

            cmp.setup.cmdline({ '/', '?' }, {
                mapping = keymap,
                sources = {
                    { name = 'buffer' },
                },
            })

            cmp.setup.cmdline(':', {
                mapping = keymap,
                sources = cmp.config.sources({
                    { name = 'path' },
                }, {
                    { name = 'cmdline' },
                }, {
                    { name = 'cmdline_history' },
                }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })
        end,
    },
}
