call plug#begin("~/.config/nvim/plugged")
	Plug 'doums/darcula'
	Plug 'scrooloose/nerdtree'
	Plug 'ryanoasis/vim-devicons'
    Plug 'itchyny/lightline.vim'
    Plug 'frazrepo/vim-rainbow'
    let g:lightline = { 'colorscheme': 'darcula' }
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-phpls']
call plug#end()

"KEY MAP
nmap <TAB> :NERDTreeToggle<CR>

"CONFIG
set number
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab 
syntax on 




"THEME CONF
if (has("termguicolors"))
	set termguicolors
endif
colorscheme darcula

"COC CONFIG

"NERFTREE CONF
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
" b:NERDTree.isTabTree()) | q | endif
" " Toggle
" nnoremap <silent> <C-b> :NERDTreeToggle<CR>

"TERMINAL CTRL N
" open new split panes to right and below
set splitright
set splitbelow
" " turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" " start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" " open terminal on ctrl+n
function! OpenTerminal()
  split term://zsh
    resize 10
    endfunction
    nnoremap <c-n> :call OpenTerminal()<CR>


"e alt+hjkl to move between split/vsplit panels
nnoremap <C-DOWN> <C-W><C-J>
nnoremap <C-UP> <C-W><C-K>
nnoremap <C-RIGHT> <C-W><C-L>
nnoremap <C-LEFT> <C-W><C-H>
