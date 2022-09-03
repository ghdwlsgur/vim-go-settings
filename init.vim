set nocompatible
filetype off


call plug#begin('~/.config/nvim/plugged')
Plug 'preservim/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shirk/vim-gas'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'folke/tokyonight.nvim', {'branch': 'main'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/vim-plug'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'
Plug 'jiangmiao/auto-pairs'
Plug 'davidhalter/jedi-vim'
Plug 'nvie/vim-flake8'
Plug 'dense-analysis/ale'
Plug 'ryanoasis/vim-devicons'
Plug 'plasticboy/vim-markdown'
Plug 'hashivim/vim-terraform'
Plug 'hashivim/vim-vagrant'
Plug 'stephpy/vim-yaml'
Plug 'jvirtanen/vim-hcl'
call plug#end()


filetype plugin on 
set encoding=utf-8
set number
set showmatch 
set path+=**
set hlsearch
set clipboard=unnamedplus
set mouse=a
set termguicolors
set viewoptions-=options
set autowrite

if has('nvim')			" nvim 을 사용 중이라면
	set inccommand=nosplit	" nvim live %s substitute (실시간 강조)
endif

" =========================================================================
" =  python3, go exec settings
" =========================================================================
" F9 파이썬 코드 실행하기 
"autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
"autocmd BufRead,BufNewFile *.py nnoremap <F5> :exec '!python' shellescape(@%, 1)<cr>

" (ctrl + shift + p) autocomplete :! python3
"map <C-S-p> :!python3<Space>
autocmd FileType python map <C-S-p> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType go map <C-S-p> :w<CR>:exec ':GoRun'<CR>
autocmd FileType go map <C-S-l> :w<CR>:exec ':GoTest'<CR>
autocmd FileType go map <C-S-k> :w<CR>:exec ':GoTestFunc'<CR>
autocmd FileType go map <C-S> :w<CR>:exec ':w'<CR>


" =========================================================================
" =  UltiSnipsExpandTrigger settings
" =========================================================================
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" =========================================================================
" =  NERDTreeToggle settings
" =========================================================================
nnoremap <silent><C-\> :NERDTreeToggle<CR><bar>:TagbarToggle <CR> 
if has("syntax")
	syntax on
endif

let g:NERDTreeWinSize=30

" =========================================================================
" =  theme settings
" =========================================================================
let g:lightline = {'colorscheme': 'tokyonight'}
let g:tokyonight_style = "night"
let g:tokyonight_italic_functions = 1
let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]
let g:tokyonight_colors = {
\ 'hint': 'orange',
\ 'error': '#f7768e'
\}
let g:tagbar_position = 'rightbelow'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#show_tabs = 1
colorscheme tokyonight
highlight ColorColumn guibg=White





" =========================================================================
" =  vim-go settings                                                           
" =========================================================================
set updatetime=100
let g:go_list_type="quickfix"
let g:go_highlight_fields=1
let g:go_highlight_functions=1
let g:go_highlight_function_calls=1
let g:go_highlight_operators=1
let g:go_highlight_extra_types=1
let g:go_highlight_build_constraints=1
let g:go_highlight_generate_tags=1
let g:go_highlight_types=1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave_enabled=1
let g:go_def_mode='godef'
let g:go_auto_type_info=1 
let g:go_auto_sameids=1
let g:go_fmt_command = "goimports"


autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle):
autocmd FileType go nmap <Leader>i <Plug>(go-info)
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd BufNewFile, BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4


" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction


