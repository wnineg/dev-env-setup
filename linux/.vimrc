set breakindent
set colorcolumn=+0
set cursorline
set expandtab
set gdefault
set hlsearch
set ignorecase
set incsearch
set linebreak
set list
set listchars=tab:⇤–⇥,trail:·,precedes:⇠,extends:⇢,nbsp:□
set mouse=
set number
set scrolloff=1
set shiftwidth=4
set showbreak=↪
set showcmd
set smartcase
set softtabstop=4
set spell
set spelllang=en_us,en_gb
set spelloptions=camel
set tabstop=4
set timeoutlen=3000
set virtualedit=onemore,block

set foldcolumn=1
set foldlevel=99
set foldlevelstart=99
set foldenable
set fillchars+=foldopen:,foldclose:

call plug#begin()

Plug 'kevinhwang91/promise-async'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'machakann/vim-highlightedyank'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'mogelbrod/vim-jsonpath'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wellle/context.vim'
Plug 'ziglang/zig.vim'

call plug#end()

if !empty($WSL_DISTRO_NAME)
    " :h clipboard-wsl
    let g:clipboard = {
                \   'name': 'WslClipboard',
                \   'copy': {
                \      '+': 'clip.exe',
                \      '*': 'clip.exe',
                \    },
                \   'paste': {
                \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
                \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
                \   },
                \   'cache_enabled': 0,
                \ }
endif

" Cursor Appearance
" Change cursor's shape based on modes
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
" Set cursor on entering
" https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
au VimEnter * silent execute '!echo -ne "\e[2 q"' | redraw!
" Restore cursor shape after exit
" https://stackoverflow.com/a/71374251
autocmd VimLeave * silent !echo -ne "\e[5 q"
" Fix the cursor change delay
" https://stackoverflow.com/a/58042714
set ttimeout
set ttimeoutlen=1
set ttyfast

" Copy from https://github.com/vim/vim/blob/master/runtime/defaults.vim
" Put these in an autocmd group, so that you can revert them with:
" ":autocmd! vimStartup"
augroup vimStartup
    autocmd!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim), for a commit or rebase message
    " (likely a different one than last time), and when using xxd(1) to filter
    " and edit binary files (it transforms input files back and forth, causing
    " them to have dual nature, so to speak)
    autocmd BufReadPost *
                \ let line = line("'\"")
                \ | if line >= 1 && line <= line("$") && &filetype !~# 'commit'
                    \      && index(['xxd', 'gitrebase'], &filetype) == -1
                    \ |   execute "normal! g`\""
                    \ | endif
augroup END

let loaded_matchparen = 1

" ------ "
" Themes "
" ------ "

" Main Theme
set background=dark
colorscheme solarized

highlight Normal ctermbg=Black

highlight SpecialKey ctermbg=8

highlight default link ColorColumn CursorColumn
highlight WinSeparator ctermbg=NONE ctermfg=White guibg=NONE guifg=White
highlight FloatBorder ctermbg=NONE guibg=NONE

highlight SpellBad ctermfg=NONE guifg=NONE
highlight SpellCap ctermfg=NONE guifg=NONE
highlight SpellRare ctermfg=NONE guifg=NONE
highlight SpellLocal ctermfg=NONE guifg=NONE

highlight DiagnosticError ctermfg=Red guifg=Red
highlight DiagnosticUnderlineError cterm=undercurl gui=undercurl guisp=Red

highlight CmpItemAbbr guifg=Grey
highlight CmpItemKind guifg=#2281C2
highlight CmpItemAbbrDeprecated
            \ cterm=strikethrough gui=strikethrough guifg=#808080
highlight CmpItemAbbrMatch guifg=#569CD6
highlight link CmpItemAbbrMatchFuzzy CmpIntemAbbrMatch
highlight CmpItemKindVariable guifg=#9CDCFE
highlight link CmpItemKindInterface CmpItemKindVariable
highlight link CmpItemKindText CmpItemKindVariable
highlight CmpItemKindFunction guifg=#C586C0
highlight link CmpItemKindMethod CmpItemKindFunction
highlight CmpItemKindKeyword guifg=#D4D4D4
highlight link CmpItemKindProperty CmpItemKindKeyword
highlight link CmpItemKindUnit CmpItemKindKeyword

" -------------- "
" Plugin Configs "
" -------------- "

" vim-airline
let g:airline_theme = 'deus'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#fzf#enabled = 1
let g:airline#extensions#nerdtree_statusline = 1
let g:airline#extensions#nvimlsp#enabled = 1
let g:airline#extensions#nvimlsp#error_symbol = ' '
let g:airline#extensions#nvimlsp#warning_symbol = ' '

" vim-gitgutter
set updatetime=100
highlight SignColumn ctermbg=Black
let g:gitgutter_set_sign_backgrounds = 1
"let g:gitgutter_diff_base = 'HEAD'

" fzf.vim
"let g:fzf_action = { 'enter': 'tab split' }

" vim-highlightedyank
let g:highlightedyank_highlight_duration = 200

" vim-easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1 " Turn on case-insensitive feature

" ------ "
" Keymap "
" ------ "

let mapleader = "\<SPACE>"

" Escaping
noremap <nowait> <ESC> <ESC>
noremap! <nowait> <ESC> <ESC>
inoremap jk <ESC>
nnoremap <BS> <ESC>
vnoremap <BS> <ESC>

" Quits command mode on <ESC>
cnoremap <nowait> <ESC> <C-c>

" disables Ex Mode
nnoremap Q <nop>

" Search Highlight Toggle
nnoremap <expr> <F3> (&hls && v:hlsearch ? ':nohls' : ':set hls') . "\n"

" Alternative arrow keys
nnoremap <C-h> <LEFT>
nnoremap <C-j> <DOWN>
nnoremap <C-k> <UP>
nnoremap <C-l> <RIGHT>
noremap! <C-h> <LEFT>
noremap! <C-j> <DOWN>
noremap! <C-k> <UP>
noremap! <C-l> <RIGHT>

" Window Adjustment
nnoremap <UP> <C-w>+
nnoremap <DOWN> <C-w>-
nnoremap <RIGHT> <C-w>>
nnoremap <LEFT> <C-w><
inoremap <UP> <C-w>+
inoremap <DOWN> <C-w>-
inoremap <RIGHT> <C-w>>
inoremap <LEFT> <C-w><
vnoremap <UP> <C-w>+
vnoremap <DOWN> <C-w>-
vnoremap <RIGHT> <C-w>>
vnoremap <LEFT> <C-w><

" Exits
nnoremap <F12> <C-c><Cmd>q!<CR>
" SHIFT+CTRL+F12
nnoremap <ESC>[24;6~ <C-c><Cmd>qa!<CR>

" Folding
nnoremap <Leader><SPACE> za
vnoremap <Leader><SPACE> zf

" Misc mapping
nnoremap q: :
nnoremap $ g$
nnoremap g$ $
" <C-_> = CTRL+/
xnoremap <C-_> <ESC>/\%V
nnoremap <C-n> <nop>

" Folding
nnoremap <Leader><SPACE> za
vnoremap <Leader><SPACE> zf

" Redo
nnoremap U <C-r>

" In-/Decrement
nnoremap + <C-a>
nnoremap - <C-x>
vnoremap + <C-a>
vnoremap - <C-x>

" Select pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
nnoremap gP <nop>

" Plugin: fzf.vim
nnoremap <Leader>o <Cmd>Files<CR>
nnoremap <Leader>f <Cmd>Rg<CR>

" Plugin: vim-easymotion
nmap  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
nmap s <Plug>(easymotion-overwin-f2)
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)

" Plugin: NERDTree
nnoremap <F5> <Cmd>exec 'NERDTreeToggle'<CR>

" Plugin: vim-easy-align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" Alternating between first non-white char and beginning of the line
function s:AltJumpToStart()
    let cnum = col('.')
    normal! ^
    if col('.') == cnum
        normal! 0
    endif
endfunction
nnoremap 0 <Cmd>call <SID>AltJumpToStart()<CR>
vnoremap 0 <Cmd>call <SID>AltJumpToStart()<CR>
nnoremap <Leader>0 0
vnoremap <Leader>0 0

" Adds n new lines (without explicitly going into the insert mode) and
" positions the cursor to the last (depends on the insertion direction) new line.
function s:InsertNewLines(n, above = 0)
    if a:n < 1
        return
    endif
    let action = (a:above ? 'O' : 'o')
    exec 'normal!' . a:n . action
    " Moves the cursor only (n - 1) upward when inserting lines above (there is already an initial upward
    " move).
    if a:above && a:n > 1
        exec 'normal!' . (a:n - 1) . 'k'
    endif
endfunction
" The following mapping maps the special cases of inserting only one line to 
" the original `o`/`O`. This is because for unknown syntax, `cc` would
" actually destroy the auto indentation derived from the previous line.
" Therefore using the native `o`/`O` can just naturally preserve the
" indentation for such case. (When inserting multiple new line for
" unknown-syntax buffer, we don't need to preserve the indentation level.)
" For count > 1, however, we need to use our own function in order to achieve
" the desired result (cursor ends at the very last inserted line). The extra
" `cc` at the end of the call can enter into the insert mode while 
" re-autoindent the line.
" NOTE: we can't just use a function to return the expression. i.e.:
"           nnoremap <expr> o <SID>DetermineNewLineMapping(v:count)
"       Since the `count` would not be cleared, resulting weird count when 
"       combining with the expression returned by the function when it already
"       considers the count in its logic.
nnoremap <expr> o
            \ (v:count <= 1 ?
            \ 'o' : '<Cmd>call <SID>InsertNewLines(v:count)<CR>cc')
nnoremap <expr> O
            \ (v:count <= 1 ?
            \ 'O' : '<Cmd>call <SID>InsertNewLines(v:count, 1)<CR>cc')

" Trims the surrounding spaces (0x20) then break the line at the current
" position.
function s:TrimAndBreak()
    " Removes the previous spaces only when the previous char is a space.
    if getline('.')[col('.') - 2] == ' '
        let [lnum, cnum] = searchpos('[^ ] ', 'bes', line('.'))
        if lnum
            normal! "_d`'
        endif
    endif
    " Removes the current & following spaces only when the current char is a
    " space.
    if getline('.')[col('.') - 1] == ' '
        let [lnum, cnum] = searchpos(' [^ ]', 'se', line('.'))
        if lnum
            normal! "_d`'
        endif
    endif
    exec "normal!i\<CR>"
endfunction
nnoremap <A-j> <Cmd>call <SID>TrimAndBreak()<CR>

" -------------------------- "
" File Type Specific Configs "
" -------------------------- "

augroup gitsetup
    autocmd!

    " Only set these commands up for git commits
    autocmd FileType gitcommit
                \ autocmd CursorMoved,CursorMovedI *
                \ let &l:textwidth = line('.') == 1 ? 0 : 120
augroup end
