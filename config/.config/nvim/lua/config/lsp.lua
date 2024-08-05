local icons = require('ref.icons').diagnostics

vim.diagnostic.config({
    severity_sort = true,
    --update_in_insert = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = icons.error,
            [vim.diagnostic.severity.WARN] = icons.warn,
            [vim.diagnostic.severity.INFO] = icons.info,
            [vim.diagnostic.severity.HINT] = icons.hint,
        }
    },
    virtual_text = {
        prefix = '⬤',
    },
})

--vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
--  buffer = 0,
--  callback = function()
--      vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
--  end
--})

local lsp_opts = {}

require('mason-lspconfig').setup({
    ensure_installed = { 'pylsp' },
})
require('lspconfig').pylsp.setup(lsp_opts)
require('lspconfig').lua_ls.setup(lsp_opts)
require('lspconfig').clangd.setup(lsp_opts)
