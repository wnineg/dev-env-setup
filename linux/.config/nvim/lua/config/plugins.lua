-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        { import = 'plugins.colorscheme.solarized8' },

        { import = 'plugins.bufferline' },
        { import = 'plugins.cmp' },
        { import = 'plugins.diffview' },
        { import = 'plugins.dressing' },
        { import = 'plugins.fzf' },
        { import = 'plugins.gitsigns' },
        { import = 'plugins.illuminate' },
        { import = 'plugins.indent_blankline' },
        { import = 'plugins.lazydev' },
        { import = 'plugins.lspconfig' },
        { import = 'plugins.lualine' },
        { import = 'plugins.luasnip' },
        { import = 'plugins.markdown' },
        { import = 'plugins.mason' },
        { import = 'plugins.navic' },
        { import = 'plugins.noice' },
        { import = 'plugins.notify' },
        { import = 'plugins.surround' },
        { import = 'plugins.treesitter' },
        { import = 'plugins.treesitter_context' },
        { import = 'plugins.trouble' },
        { import = 'plugins.ufo' },
    },
    install = { colorscheme = { 'solarized8' } },
})
