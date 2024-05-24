set expandtab
set hlsearch
set ignorecase
set incsearch
set number
set scrolloff=1
set shiftwidth=4
set showcmd
set smartcase
set softtabstop=4
set tabstop=4

call plug#begin()

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
Plug 'vim-python/python-syntax'
Plug 'wellle/context.vim'
Plug 'ziglang/zig.vim'

call plug#end()

" Cursor Appearance
if has('nvim')
    " Restore cursor fix the neovim
    augroup RestoreCursorShapeOnExit
        autocmd!
        autocmd VimLeave * set guicursor=a:ver20-blinkon1
    augroup END
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

" -------------- "
" Plugin Configs "
" -------------- "

" vim-colors-solarized
syntax enable
set background=dark
colorscheme solarized

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

inoremap jk <ESC>
nnoremap <silent> <C-l> :noh<CR>
nnoremap U <C-r>
nnoremap <BS> i<BS><ESC>l

" fzf.vim
nnoremap <silent> <C-O> :Files <CR>
nnoremap <silent> <A-f> :Rg <CR>

" vim-easymotion
noremap  <Leader>f <Plug>(easymotion-bd-f)
nnoremap <Leader>f <Plug>(easymotion-overwin-f)
nnoremap s <Plug>(easymotion-overwin-f2)
noremap <Leader>j <Plug>(easymotion-j)
noremap <Leader>k <Plug>(easymotion-k)

" NERDTree
nnoremap <F5> :exec 'NERDTreeToggle' <CR>

" Alternating between first non-white char and beginning of the line
function AltJumpToStart(virtual = 0)
    if a:virtual
        normal! gv
    endif
    let cnum = match(getline('.'), '\S') + 1
    if col('.') == cnum
        normal! 0
    else
        exec 'normal!' . cnum . '|'
    endif
endfunction
nnoremap <silent> 0 :call AltJumpToStart()<CR>
vnoremap <silent> 0 :call AltJumpToStart(1)<CR>

" Similarly to the native commands 'o' and 'O' but works nicely with repeat
" count.
function InsertNewLines(n, above = 0)
    let action = (a:above ? 'O' : 'o')
    " Only inserts (n - 1) lines here, as to leave one 'new line' action to
    " preserve the auto indentation at the end.
    if a:n > 1
        exec 'normal!' . (a:n - 1) . action
    endif
    " Moves the cursor only (n - 2) when inserting lines above, because there
    " are two moving up by the two `O` actions already when n >= 2. 
    if a:above && a:n > 2
        exec 'normal!' . (a:n - 2) . 'k'
    endif
    " The trick to preserve the auto indentation.
    " https://vi.stackexchange.com/a/4409
    exec 'normal!' . action . "\<SPACE>\<BS>\<ESC>"
    startinsert!
endfunction
nnoremap <silent> o :<C-u>call InsertNewLines(v:count)<CR>
nnoremap <silent> O :<C-u>call InsertNewLines(v:count, 1)<CR>

" Add an additional empty line after inserting new lines if the 'next' line 
" following the insertion direction isn't empty.
function InsertIsolatedLines(n, above = 0)
    call InsertNewLines(a:n, a:above)
    if a:above
        if line('.') != 1 && getline(line('.') - 1) !~ '^\s*$'
            normal! O
            normal! j
        endif
    elseif line('.') != line('$') && getline(line('.') + 1) !~ '^\s*$'
        normal! o
        normal! k
    endif
endfunction
nnoremap <silent> <leader>o :<C-u>call InsertIsolatedLines(v:count)<CR>
nnoremap <silent> <leader>O :<C-u>call InsertIsolatedLines(v:count, 1)<CR>

" Trims the surrounding spaces (0x20) then break the line at the current
" position.
function TrimAndBreak()
    " Removes the previous spaces only when the previous char is a space.
    if getline('.')[col('.') - 2] == ' '
        let [lnum, cnum] = searchpos('[^ ] ', 'bes', line('.'))
        if lnum
            normal! "_d`'
        endif
    endif
    " Removes the following spaces only when the current char is a space.
    if getline('.')[col('.') - 1] == ' '
        let [lnum, cnum] = searchpos(' [^ ]', 's', line('.'))
        if lnum
            normal! "_d`'
        endif
    endif
    exec "normal!i\<CR>"
endfunction
nnoremap <silent> <C-j> :call TrimAndBreak()<CR>

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
