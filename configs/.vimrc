set breakindent
set colorcolumn=+0
set cursorline
set expandtab
set hlsearch
set ignorecase
set incsearch
set linebreak
set list
set listchars=tab:⇤–⇥,space:·,trail:·,precedes:⇠,extends:⇢,nbsp:×
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

call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'ishan9299/nvim-solarized-lua'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'machakann/vim-highlightedyank'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'mogelbrod/vim-jsonpath'
Plug 'ms-jpq/coq_nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-python/python-syntax'
Plug 'wellle/context.vim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'williamboman/mason.nvim'
Plug 'ziglang/zig.vim'

call plug#end()

" Cursor Appearance
if has('nvim')
    let nvimVer = v:lua.vim.version()
    " The cursor issue only happens for some versions < 0.10.x
    if nvimVer.major == 0 && nvimVer.minor < 10
        " Restore cursor fix the neovim
        augroup RestoreCursorShapeOnExit
            autocmd!
            autocmd VimLeave * set guicursor=a:ver20-blinkon1
        augroup END
    endif
else
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
endif

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

" ------ "
" Themes "
" ------ "

" Highlight trailing spaces
if !has('nvim')
    " VIM requires the highlight group be defined before the match
    highlight ExtraWhitespace ctermbg=DarkGreen guibg=DarkGreen
endif
match ExtraWhitespace /\s\+$/

augroup preColorSchemeSetup
    autocmd!

    autocmd ColorScheme *
            \ highlight ExtraWhitespace ctermbg=DarkGreen guibg=DarkGreen
augroup END

" Main Theme
if has('nvim')
    colorscheme solarized8
else
    set background=dark
    colorscheme solarized
endif

highlight default link ColorColumn CursorColumn

highlight DiagnosticError ctermfg=Red guifg=Red
highlight DiagnosticUnderlineError cterm=undercurl gui=undercurl guisp=Red

" -------------- "
" Plugin Configs "
" -------------- "

let g:coq_settings = { 'auto_start': v:true }

"vim-airline
let g:airline_theme = 'deus'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" vim-gitgutter
set updatetime=100
highlight SignColumn ctermbg=Black
let g:gitgutter_set_sign_backgrounds = 1
"let g:gitgutter_diff_base = 'HEAD'

" Enable all vim-python/python-syntax syntax highlights
let g:python_highlight_all = 1

" fzf.vim config
let g:fzf_action = { 'enter': 'tab split' }

" vim-highlightedyank
let g:highlightedyank_highlight_duration = 200

" vim-easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1 " Turn on case-insensitive feature

" ------ "
" Keymap "
" ------ "

let mapleader = "\<SPACE>"

" Misc mapping
nnoremap q: <nop>
nnoremap <expr> <C-l> (&hls && v:hlsearch ? ':nohls' : ':set hls') . "\n"
nnoremap $ g$
nnoremap g$ $
" <C-_> is actually <C-/>
xnoremap <C-_> <ESC>/\%V

" Quitting
noremap <F12> <Cmd>q!<CR>
" <F36> = <C-F12>
noremap <F36> <Cmd>qa!<CR>

" Escaping
inoremap jk <ESC>
nnoremap <BS> <ESC>
onoremap <BS> <ESC>
vnoremap <BS> <ESC>

" Editing under normal mode
nnoremap U <C-r>

" Select pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
nnoremap gP <nop>

" fzf.vim
nnoremap <silent> <A-o> :Files <CR>
nnoremap <silent> <A-f> :Rg <CR>

" vim-easymotion
nmap  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
nmap s <Plug>(easymotion-overwin-f2)
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)

" NERDTree
nnoremap <silent> <F5> :exec 'NERDTreeToggle' <CR>

" vim-easy-align
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
" positions the cursor to last (depends on the insertion direction) new line.
function s:InsertNewLines(n, above = 0)
    if a:n < 1
        return
    endif
    let action = (a:above ? 'O' : 'o')
    exec 'normal!' . a:n . action
    " Moves the cursor only (n - 1) upward when inserting lines above (there is
    " already an initial upward move).
    if a:above && a:n > 1
        exec 'normal!' . (a:n - 1) . 'k'
    endif
endfunction
" The below two mappings add n lines using the function first, then use the
" `cc` command to enter the insert mode with autoindent.
"nnoremap <silent> o :<C-u>call <SID>InsertNewLines(v:count ?? 1)<CR>cc
nnoremap o <Cmd>call <SID>InsertNewLines(v:count ?? 1)<CR>cc
nnoremap O <Cmd>call <SID>InsertNewLines(v:count ?? 1, 1)<CR>cc

" Starts a new paragraph without entering the insert mode. Extra padding lines
" might be inserted between the existing and new lines.
function s:StartNewParagraph(above = 0)
    let op = (a:above ? 'O' : 'o')
    " Step to the line# of _next_ (depends on the insertion direction) line
    let nlStep = (a:above ? -1 : 1)

    " If the current is not an empty line, we need a padding.
    if getline(line('.')) !~ '^\s*$'
        exec 'normal!' . op
    endif

    " Inserts the line where the cursor will eventually end up
    exec 'normal!' . op

    " Inserts additional padding before _next_ line if it is not empty
    let nl = line('.') + nlStep
    if 1 <= nl && nl <= line('$') && getline(nl) !~ '^\s*$'
        exec 'normal!' . op
        call cursor(line('.') - nlStep, col('.'))
    endif
endfunction
" Starts a new line below/above isolated from the other non-blank lines. Uses
" the native `cc` command at last to enter the insert mode with autoindent
" preserved.
nnoremap <leader>o <Cmd>call <SID>StartNewParagraph()<CR>cc
nnoremap <leader>O <Cmd>call <SID>StartNewParagraph(1)<CR>cc

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
    " Removes the following spaces only when the current char is a space.
    if getline('.')[col('.') - 1] == ' '
        let [lnum, cnum] = searchpos(' [^ ]', 'se', line('.'))
        if lnum
            echom 'Next non-space at: ' . cnum
            normal! "_d`'
        endif
    endif
    exec "normal!i\<CR>"
endfunction
nnoremap <C-j> <Cmd>call <SID>TrimAndBreak()<CR>

" Works like the native `{` and `}` but aware of indented paragraphs.
function s:JumpToNextParag(reverse)
    if a:reverse
        let step = -1
        let CheckBound = {n -> n != 1}
    else
        let step = 1
        let last = line('$')
        let CheckBound = {n -> n != last}
    endif

    let lnum = line('.')
    if getline(lnum) =~ '^\s*$'
        while getline(lnum) =~ '^\s*$' && CheckBound(lnum)
            let lnum += step
        endwhile
    endif
    while getline(lnum) !~ '^\s*$' && CheckBound(lnum)
        let lnum += step
    endwhile
    exec 'normal!' . lnum . 'gg^'
endfunction
nnoremap { <Cmd>call <SID>JumpToNextParag(1)<CR>
nnoremap } <Cmd>call <SID>JumpToNextParag(0)<CR>
vnoremap { <Cmd>call <SID>JumpToNextParag(1)<CR>
vnoremap } <Cmd>call <SID>JumpToNextParag(0)<CR>

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

