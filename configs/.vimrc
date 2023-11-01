set hlsearch
set showcmd
set incsearch
set scrolloff=1
set number
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

call plug#begin()

Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'easymotion/vim-easymotion'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'editorconfig/editorconfig-vim'
Plug 'ziglang/zig.vim'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'

call plug#end()

" vim-colors-solarized
syntax enable
set background=dark
colorscheme solarized

" Cursor config
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

noremap <Leader>0 ^

" This unsets the 'last search pattern' register by hitting return
nnoremap <silent> <C-l> :noh<CR>
" Toggle NERDTree
nnoremap <F5> :exec 'NERDTreeToggle' <CR>

" fzf.vim config
nnoremap <silent> <C-O> :Files <CR>
nnoremap <silent> <A-f> :Rg <CR>
let g:fzf_action = { 'enter': 'tab split' }

" --------------------------- "
" Start vim-easymotion config "
" --------------------------- "

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" ------------------------- "
" End vim-easymotion config "
" ------------------------- "

augroup gitsetup
    autocmd!

    " Only set these commands up for git commits
    autocmd FileType gitcommit
                \ autocmd CursorMoved,CursorMovedI *
                \ let &l:textwidth = line('.') == 1 ? 0 : 120
augroup end
