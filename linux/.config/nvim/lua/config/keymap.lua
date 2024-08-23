vim.g.mapleader = vim.keycode([[<SPACE>]])

local function map(from, modes, to, opts)
    vim.keymap.set(modes, from, to, opts)
end

-- Quits command mode on <ESC>
map('<ESC>', 'c', '<C-c>')

-- Search Highlight Toggle
map('<F3>', 'n', function()
    if vim.o.hlsearch and vim.v.hlsearch == 1 then
        vim.opt.hlsearch = false
    else
        vim.opt.hlsearch = true
    end
end, { silent = true })

-- Alternative arrow keys
map('<C-h>', { 'n', 'i', 'c' }, '<LEFT>')
map('<C-j>', { 'n', 'i', 'c' }, '<DOWN>')
map('<C-k>', { 'n', 'i', 'c' }, '<UP>')
map('<C-l>', { 'n', 'i', 'c' }, '<RIGHT>')

--map('q:', 'n', ':')
--map('<C-_>', 'v', [[<ESC>/\%\/]])

-- Windows
map('<UP>', { 'n', 'i', 'v' }, '<C-w>k')
map('<DOWN>', { 'n', 'i', 'v' }, '<C-w>j')
map('<RIGHT>', { 'n', 'i', 'v' }, '<C-w>l')
map('<LEFT>', { 'n', 'i', 'v' }, '<C-w>h')
map('<A-UP>', { 'n', 'i', 'v' }, '<C-w>+')
map('<A-DOWN>', { 'n', 'i', 'v' }, '<C-w>-')
map('<A-RIGHT>', { 'n', 'i', 'v' }, '<C-w>>')
map('<A-LEFT>', { 'n', 'i', 'v' }, '<C-w><')

-- Exits
map('<F12>', { 'n', 'i', 'c' }, '<C-c><Cmd>q!<CR>')
map('<F48>', { 'n', 'i', 'c' }, '<C-c><Cmd>qa!<CR>') -- CTRL+SHIFT+F12

-- Escaping
map('jk', 'i', '<ESC>')
map('<BS>', { 'n', 'o', 'v' }, '<ESC>')
map('g<BS>', 'n', '<nop>')

-- Folding
map('<Leader><SPACE>', 'n', 'za')
map('<Leader><SPACE>', 'v', 'zf')

-- Redo
map('U', 'n', '<C-r>')

-- In-/Decrement
map('+', { 'n', 'v' }, '<C-a>')
map('-', { 'n', 'v' }, '<C-x>')

-- Select pasted text
map('gp', 'n', function() return '`[' .. string.sub(vim.fn.getregtype(), 1, 1) .. '`]' end, { expr = true })
map('gP', 'n', '<nop>')

-- Jumps between first non-blank char and very first column of the current line.
map('0', { 'n', 'v' }, function()
    local cnum = vim.fn.col('.')
    vim.cmd.normal { '^', bang = true }
    if cnum == vim.fn.col('.') then
        vim.cmd.normal { '0', bang = true }
    end
end)
map('<Leader>0', { 'n', 'v' }, '0')

-- Inserts new lines and moves the cursor to the furtherest inserted line.
map('o', 'n', function()
    if vim.v.count <= 1 then
        -- Unlike v:count > 1, we don't need to `<ESC>cc` at the end, otherwise the auto indentation
        -- would get destroyed in some cases (e.g. when the file format is unknown).
        vim.api.nvim_feedkeys('o', 'n', false)
    else
        local keys = vim.keycode(vim.v.count .. 'o<ESC>cc')
        vim.api.nvim_feedkeys(keys, 'n', false)
    end
end)
map('O', 'n', function()
    if vim.v.count <= 1 then
        -- Unlike v:count > 1, we don't need to `<ESC>cc` at the end, otherwise the auto indentation
        -- would get destroyed in some cases (e.g. when the file format is unknown).
        vim.api.nvim_feedkeys('O', 'n', false)
    else
        -- Unlike inserting lines below, we need to explicitly move the cursor upward (v:count - 1) lines when
        -- inserting lines above, so that the cursor can end up at the furtherest inserted line.
        local keys = vim.keycode(vim.v.count .. 'O<ESC>' .. (vim.v.count - 1) .. 'kcc')
        vim.api.nvim_feedkeys(keys, 'n', false)
    end
end)

-- Trims the white spaces surrounding the cursor and breaks the line there.
map('<A-j>', 'n', function()
    local prev_cnum = vim.fn.col('.') - 1
    if prev_cnum and vim.fn.getline('.'):sub(prev_cnum, prev_cnum) == ' ' then
        local lnum = vim.fn.searchpos('[^ ] ', 'bes', vim.fn.line('.'))[1]
        -- Set the 'x' flag to wait for the keys to complete.
        if lnum > 0 then vim.api.nvim_feedkeys([["_d`']], 'nx', false) end
    end
    local _, lnum, cnum = unpack(vim.fn.getpos('.'))
    if vim.fn.getline('.'):sub(cnum, cnum) == ' ' then
        lnum = vim.fn.searchpos(' [^ ]', 'se', lnum)[1]
        if lnum > 0 then vim.api.nvim_feedkeys([["_d`']], 'n', false) end
    end
    vim.api.nvim_feedkeys(vim.keycode('i<CR><ESC>'), 'n', false)
end)

-- LSP
map('<C-q>', 'n', function() vim.lsp.buf.hover() end)
map('<C-r>', 'n', function() vim.lsp.buf.rename() end)
