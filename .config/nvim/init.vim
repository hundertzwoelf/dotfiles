set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
" source ~/.vimrc

" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Load plugins here (vim-plug)
call plug#begin()

" Git
Plug 'tpope/vim-fugitive' " awesome git plugin

" Syntax
Plug 'scrooloose/syntastic' " better syntax highlighting
Plug 'PotatoesMaster/i3-vim-syntax' " enabling proper syntax highlighting for i3 config file

" Completion
Plug 'ajh17/VimCompletesMe' " better completion
Plug 'davidhalter/jedi-vim' " showing function headers

" Tex
Plug 'lervag/vimtex' " nice integration of tex into neovim

" Pandoc
Plug 'conornewton/vim-pandoc-markdown-preview' " preview markdown files directly in zathura

" R
Plug 'jalvesaq/Nvim-R' " R integration with REPL etc.

" Python
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' } " code/syntax checking etc
Plug 'rhysd/reply.vim' " allow to open REPL's inside neovim
Plug 'KangOl/vim-pudb' " python debugging

" Theming
Plug 'mhinz/vim-startify' " Landing page
Plug 'ryanoasis/vim-devicons' " Icons for Nerdtree etc
Plug 'vim-airline/vim-airline' " Bottom bar
Plug 'vim-airline/vim-airline-themes' " Bottom bar themes
Plug 'rafi/awesome-vim-colorschemes' " several colorschemes
Plug 'vim-scripts/colorizer' " show hex codes as actual colors
Plug 'Yggdroot/indentLine' " adding an indentation character for python
Plug 'lukas-reineke/indent-blankline.nvim' " adding an indentation character for empty lines
Plug 'chuling/equinusocio-material.vim' " nice theme

" Be more productive
Plug 'preservim/nerdcommenter' " comment lines with handy keybindings
Plug 'jeetsukumaran/vim-buffergator' " handling buffers more easily
Plug 'junegunn/fzf.vim' " fuzzy-finding files and other things
Plug 'preservim/nerdtree' " nice folder structure tree
Plug 'tpope/vim-surround' " change surroundings easily

" Other
Plug 'dag/vim-fish' " integrate fish shell better
Plug 'lambdalisue/suda.vim' " workaround to write read-only files

call plug#end()
filetype plugin on

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" leader key <Space>
let mapleader = " "

" Set title
set title

" Security
set modelines=1

" Show line numbers
set number relativenumber

" Mouse
set mouse=a

" Text rendering
set encoding=utf-8
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set smartindent
set shiftround

" Cursor motion
set scrolloff=3
set sidescrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between < and >
set showmatch

" Color scheme (terminal)
set background=dark
set termguicolors
colorscheme onedark

" Highlighting
hi Normal guibg=NONE ctermbg=NONE
hi Conceal guifg=#61AFEF guibg=NONE
" hi Folded guibg=#61AFEF

" Allow hidden buffers
set nohidden

" Spelling
set spelllang=de,en

" Show commands in the bottom right
set showcmd

" Set confirm
set confirm

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
" clear search
map <leader>/ :nohl<CR>

" Enabling undo across sessions
set undofile
set undodir=~/.vim/undodir

" Split more naturally
set splitbelow
set splitright

" Make escaping terminal more easy
tnoremap <Esc> <C-\><C-n>

" Formatting
map <leader>q gqip
map <leader>= =ip

" Resize split windows
noremap <silent> <C-Right> :vertical resize +3<CR>
noremap <silent> <C-Left> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

" Navigate around splits more naturally
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

" Move up/down editor lines
" nnoremap j gj
" nnoremap k gk

" Escaping with ;;
inoremap ;; <ESC>
vnoremap ;; <ESC>
cnoremap ;; <C-c><ESC>
tnoremap ;; <ESC>
onoremap ;; <ESC>

" some insert mode simplifications
inoremap <C-]> <C-X><C-]>
inoremap <C-F> <C-X><C-F>
inoremap <C-L> <C-X><C-L>

" Leader commands
" Edit nvim config file
nnoremap <Leader>ve :e ~/.config/nvim/init.vim<CR>
" Reload nvim config file
nnoremap <Leader>vr :source ~/.config/nvim/init.vim<CR>
" Toggle color highlighting
nnoremap <Leader>h :ColorToggle<CR>
" Open up fish shell
nnoremap <Leader>tt :vnew term://fish<CR>i
" Open empty buffer
nnoremap <leader>e :enew<CR>
" REPL commands
nnoremap <leader>rp :Repl<CR>
vnoremap <leader>rp :Repl<CR>
nnoremap <leader>rs :ReplSend<CR>
vnoremap <leader>rs :ReplSend<CR>
nnoremap <leader>ra :ReplAuto<CR>
" toggle spellcheck
nnoremap <leader>s :setlocal spell!<CR>

" F commands
" remove trailing whitespace
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

"execute python scripts internally
au FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

" implementing a placeholder functionality (forward & backward)
" TODO maybe better shortcuts?
inoremap <M-j> <ESC>/<++><CR>cw
inoremap <M-k> <ESC>?<++><CR>cw
nnoremap <M-j> /<++><CR>cf>
nnoremap <M-k> ?<++><CR>cf>
" inserting placeholder
inoremap <M-i> <++><Space>
nnoremap <M-i> i<++> <ESC>

"""""""""""""""""""
" Plugin settings "
"""""""""""""""""""

" Syntastic
let g:syntastic_tex_lacheck_quiet_messages = { 'regex': '\Vpossible unwanted space at'}
let g:syntastic_tex_chktex_quiet_messages = { 'regex': ['\VYou should enclose the previous parenthesis', '\Vwrong length of dash',  '\VUse either `` or '] }

" Tex options
let g:vimtex_compiler_latexmk = {
      \ 'backend' : 'nvim',
      \ 'background' : 1,
      \ 'build_dir' : '',
      \ 'callback' : 1,
      \ 'continuous' : 1,
      \ 'executable' : 'latexmk',
      \ 'hooks' : [],
      \ 'options' : [
      \   '-verbose',
      \   '-shell-escape',
      \   '-file-line-error',
      \   '-interaction=nonstopmode',
      \   '-synctex=1',
      \ ],
      \}

let g:vimtex_complete_close_braces = 1
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_automatic = 0
let g:vimtex_format_enabled = 1
let g:vimtex_fold_enabled = 1
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'

au FileType tex call SetTexOptions()
" au ColorScheme *.tex highlight Conceal ctermfg=4

function SetTexOptions()
    setlocal spell
    setlocal cole=2
    setlocal cocu=v
endfunction

" Airline + Tabline
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#formatter = 'jsformatter'

" Nerdtree
let g:NERDSpaceDelims = 1
map <C-n> :NERDTreeToggle<CR>

" Better indentation
let g:indentLine_char = '▏'
let g:indentLine_fileType = ['c', 'cpp', 'python']
let g:indentLine_setColors = 0

let g:indent_blankline_extra_indent_level = -1
let g:indent_blankline_char = '▏'

" Pymode
let g:pymode = 1
let g:pymode_lint = 1 " code checking enabled
let g:pymode_lint_ignore = ["E501", "E302", "W293"] " ignore line too long
let g:pymode_options = 1
let g:pymode_preview_height = 12
let g:pymode_preview_position = 'botright'
let g:pymode_run = 1
let g:pymode_run_bind = '<F12>'
let g:pymode_breakpoint = 0
let g:pymode_trim_whitespaces = 0
let g:pymode_options_colorcolumn = 0

" Disable pep8
" let g:python_recommended_style = 0

" vim-startify
let g:startify_custom_header =
            \ startify#pad(split(system('figlet -c -f slant neovim'), '\n'))


" fzf-vim
nnoremap <C-P> :Files ~<CR>
nnoremap <leader>p :Files<CR>
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
autocmd! FileType fzf set laststatus=0 noshowmode noruler norelativenumber
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
let g:fzf_preview_window = 'right:60%'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }


" Pandoc
let g:md_pdf_viewer="zathura"

let g:reply_repls = {
            \   'python': ['ptpython']
            \ }

let g:suda_smart_edit = 1
