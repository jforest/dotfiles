execute pathogen#infect()
syntax on
set number
set nocompatible
filetype plugin indent on
set ts=4
set sts=4
set sw=4
set smartindent
"set autoindent
set expandtab
set laststatus=2
set background=dark
colorscheme solarized
set guifont=Ubuntu\ Mono\ derivative\ Powerline
if !has('gui_running')
  set t_Co=256
endif
let g:lightline = {
      \ 'colorscheme': 'solarized_dark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'readonly': 'MyReadonly',
      \   'modified': 'MyModified',
      \   'filename': 'MyFilename'
      \ },
      \ 'separator': { 'right': '', 'left': '' },
      \ 'subseparator': { 'right': '', 'left': '' }
      \ }

function! MyModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! MyReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! MyFugitive()
  return exists('*fugitive#head') && strlen(fugitive#head()) ? ' '.fugitive#head() : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ ('' != expand('%t') ? expand('%t') : '[No Name]') .
       \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Shortcut to retab!
nmap <leader>r :retab!<CR>

" fire up ctrlp
nmap <leader>f :CtrlP<CR>
nmap <leader>. :CtrlPTag<CR>

" fire up the silver searcher
nmap <leader>a :Ag! 

" Fire up the tagbar
nmap <leader>b :TagbarToggle<CR>

" Ctags stuff
nmap <leader>c :tag 

" set paste
nmap <leader>p :set paste!<CR>

" set nonumber
nmap <leader>n :set nonumber!<CR>

" Thoughtbot vimconfigs 
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Flake8
"nmap <leader>8 :call Flake8()<CR>
nmap <leader>s :SyntasticCheck<CR>
let g:syntastic_go_checkers = ['golint']
let g:syntastic_ruby_checkers = ['rubocop']

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" 80 chars?
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/
if exists('+colorcolumn')
  set colorcolumn=120
else
  highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  match OverLength /\%81v.\+/
endif

let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype perl setlocal ts=4 sts=4 sw=4
autocmd Filetype yaml setlocal ts=2 sts=2 sw=2
