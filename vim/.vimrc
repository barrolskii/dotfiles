let mapleader = " "
let maplocalleader = "\\"


set tabstop=4
set shiftwidth=4
set number

set nohlsearch
set incsearch

"set termguicolors
set splitbelow splitright

" Disable the screen flash on Windows
set t_vb=

" Always have the status bar at the bottom. (Default for Git Bash)
set laststatus=2

call plug#begin('~/.vim/plugged')

" Autocompletion and syntax checking
Plug 'ycm-core/YouCompleteMe'
Plug 'scrooloose/syntastic'

Plug 'junegunn/goyo.vim'

" Syntax highlighting
Plug 'ap/vim-css-color'

" Documentation
"Plug 'vimwiki/vimwiki'

Plug 'vim-airline/vim-airline'

" Themes
"Plug 'morhetz/gruvbox'
"Plug 'tomasiser/vim-code-dark'

call plug#end()

" Set the colorscheme to be default
colorscheme default
syntax on

" Change the background color of the folded sections as it's too bright
" with termguicolors enabled
highlight Folded guibg=#2b2b2b

highlight Pmenu guibg=#2b2b2b

" Highlight column 81
set colorcolumn=81
highlight ColorColumn guibg=#2b2b2b

" Syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Ycm settings
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/plug-config/.ycm_extra_conf.py'
let g:ycm_max_diagnostics_to_display=0
let g:ycm_show_diagnostics_ui=0 " Stops error checking. That's what
								" Syntastic is for

let g:ycm_semantic_triggers = {
	\ 'c': ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h',
	\		'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
	\ 		'q', 'r', 's', 't', 'u', 'v', 'w', 'x',
	\		'y', 'z'],
\}


" Status line settings {{{

""set statusline+=%#warningmsg#
""set statusline+=%{SyntasticStatuslineFlag()}
""set statusline+=%*
""
""set statusline=%f                " Current file
""set statusline+=\ --             " Separator
""set statusline+=\ %y             " Filetype
""set statusline+=\ --\            " Separator
""set statusline+=Line\ [%4l/%L]   " Current line / total lines in file
""set statusline+=\ --\            " Separator
""set statusline+=Char\ [%3c]      " Current column
""set statusline+=%=               " Swap to right side
""set statusline+=%F               " Print full path of file

" }}}


" Basic abbrev and remap settings {{{

" Make word uppercase
noremap <leader>u viwU

" Make word lowercase
noremap <leader>l viwu

" Shortcut to open .vimrc and to refresh changes
nnoremap <leader>ev :vsp ~/.vimrc<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>

" Wrap current word in single quotes or double quotes
nnoremap <leader>" ea"<esc>bi"<esc>lel
nnoremap <leader>' ea'<esc>bi'<esc>lel

" Surround highlighted words with either (, {, [ or <
vnoremap <leader>( di(<esc>pa)<esc>
vnoremap <leader>{ di{<esc>pa}<esc>
vnoremap <leader>[ di[<esc>pa]<esc>
vnoremap <leader>< di<<esc>pa><esc>

" Surround words from cursor with either (, {, [ or <
nnoremap <leader>( i(<esc>A)<esc>
nnoremap <leader>{ i{<esc>A}<esc>
nnoremap <leader>[ i[<esc>A]<esc>
nnoremap <leader>< i<<esc>A><esc>

inoremap " ""<left>

nnoremap H 0
nnoremap L $

" For vim in Git bash, when CTRL-<backspace> is pressed, delete the current word and
" don't save it to a register use the black hole register instead
inoremap ­ <esc>b"_dwa

" Yank current line with yl instead of y$
onoremap l $

" Keys to move between multiple windows
nnoremap <c-h> :wincmd h<cr>
nnoremap <c-j> :wincmd j<cr>
nnoremap <c-k> :wincmd k<cr>
nnoremap <c-l> :wincmd l<cr>

nnoremap <leader>g :Goyo<cr>

" }}}


" C File settings {{{

augroup filetype_c
	autocmd!

	let g:ycm_global_ycm_extra_conf = '~/.config/nvim/plug-config/.ycm_c_conf.py'

	autocmd BufNewFile main.c 0r $TEMPLATES/template.c
	autocmd BufNewFile main.cpp 0r $TEMPLATES/template.cpp
	autocmd BufNewFile *.c nnoremap <leader>w :match Error /\s\+$/<cr>

	autocmd FileType c,cpp nnoremap <buffer> <localleader>c I//<esc>
	autocmd FileType c,cpp nnoremap <buffer> <leader>; mqA;<esc>`q

	autocmd FileType c setlocal foldmethod=marker

	autocmd FileType c  nnoremap <buffer> <leader>i i#include<space>

	autocmd FileType c vnoremap <buffer> <leader>mc di<esc>:execute "vsp " . @* . ".h"<cr>
	autocmd FileType c	nnoremap <buffer> <localleader>cc 0ebi<delete><delete><esc>

	autocmd FileType c nnoremap <buffer> <leader>m :!make<cr>
	autocmd FileType c nnoremap <buffer> <leader>p aprintf("\n");<esc>4hi
augroup END

" }}}


" h file settings {{{

augroup filetype_c_header
	autocmd!
	autocmd BufNewFile *.h 0r $TEMPLATES/template.h
	autocmd BufNewFile *.h exe "1," . 7 . "g/#ifndef/s//#ifndef " .toupper(join([fnamemodify(expand("%"), ':t:r'), '_H'], ''))
	autocmd BufNewFile *.h exe "1," . 7 . "g/#define/s//#define " .toupper(join([fnamemodify(expand("%"), ':t:r'), '_H'], ''))
	autocmd BufNewFile *.h exe "1," . 7 . "g,#endif,s,,#endif \\//" .toupper(join([fnamemodify(expand("%"), ':t:r'), '_H'], ''))
	autocmd BufNewFile *.h exe ":4"

	nnoremap <buffer> <leader>mc iclass <c-r>=fnamemodify(expand("%"), ':t:r')<cr><cr>{<cr><cr>}<up>

	autocmd BufNewFile *.h :inoreabbrev <buffer> pri private:<cr>
	autocmd BufNewFile *.h :inoreabbrev <buffer> pub public:<cr>
augroup END

" }}}


" vim file settings {{{

augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
	autocmd FileType vim :iabbrev <buffer> aug augroup
	autocmd FileType vim :iabbrev <buffer> auge augroup END
	autocmd FileType vim :iabbrev <buffer> aut autocmd
	autocmd FileType vim :iabbrev <buffer> ft FileType
	autocmd FileType vim :iabbrev <buffer> bnf BufNewFile
	autocmd FileType vim :iabbrev <buffer> iab iabbrev
	autocmd FileType vim :iabbrev <buffer> ino inoremap
	autocmd FileType vim :iabbrev <buffer> nno nnoremap
	autocmd FileType vim :iabbrev <buffer> vno vnoremap
	autocmd FileType vim :iabbrev <buffer> ono onoremap
	autocmd FileType vim :iabbrev <buffer> buf <buffer>
	autocmd FileType vim :iabbrev <buffer> fun function!
	autocmd FileType vim :iabbrev <buffer> enf endfunction
	autocmd FileType vim nnoremap <buffer> <localleader>c mq0i"<esc>`q
	autocmd FileType vim nnoremap <buffer> <tab> za
augroup END

" }}}


" sh file settings {{{

augroup filetype_bash
	autocmd!
	autocmd BufNewFile *.sh 0r $TEMPLATES/template.sh
	autocmd BufNewFile *.sh exe "normal jo"

	autocmd FileType sh nnoremap <localleader># mq0i#<esc>`q
augroup END

" }}}


" md file settings {{{

augroup filetype_markdown
	autocmd!
   	autocmd FileType markdown :onoremap ih :<c-u>execute "normal! ?^[==,--]\\+$\r:nohlsearch\rkvg_"<cr>
	autocmd FileType markdown :onoremap ah :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rg_vk0"<cr>

	iabbrev ` ```<cr><cr>```<up><up>
augroup END

" }}}


" {{{

augroup filetype_make
	autocmd!
	autocmd BufNewFile makefile 0r $TEMPLATES/makefile.txt
augroup END

"  }}}


" html file settings {{{

augroup filetype_html
	autocmd!
	autocmd BufNewFile *.html 0r $TEMPLATES/template.html
	autocmd FileType html nnoremap <buffer> <leader>> vit<esc>i
	autocmd FileType html nnoremap <buffer> <leader><leader> :call FindPlaceholder()<cr>i

	autocmd FileType html nnoremap <buffer> <leader>1 a<h1></h1><esc>4hi
	autocmd FileType html nnoremap <buffer> <leader>2 a<h2></h2><esc>4hi
	autocmd FileType html nnoremap <buffer> <leader>3 a<h3></h3><esc>4hi

	autocmd FileType html nnoremap <buffer> <leader>p a<p></p><esc>3hi
	autocmd FileType html nnoremap <buffer> <localleader>c a<!-- --><esc>4hi

	autocmd FileType html nnoremap <buffer> <leader>ul a<ul><cr><cr></ul><esc>ki
	autocmd FileType html nnoremap <buffer> <leader>li a<li></li><esc>4hi
	autocmd FileType html nnoremap <buffer> <leader>a a<a></a><esc>3hi

	autocmd FileType html nnoremap <buffer> <leader>tr a<tr><return><return></tr><esc><up>i
	autocmd FileType html nnoremap <buffer> <leader>td a<td></td><esc>3hi
	autocmd FileType html nnoremap <buffer> <leader>th a<th></th><esc>4hi

	autocmd FileType html nnoremap <buffer> <leader>pr a<pre><cr><code><cr><cr><cr><cr></code><cr></pre><esc>3ki

	autocmd FileType html setlocal spell spelllang=en_gb
augroup END

function! FindPlaceholder()

   /<++>
	normal 0f+hda<

endfunction

" }}}


" LaTeX file settings {{{

augroup filetype_tex
	autocmd!
	autocmd FileType tex :iabbrev sec <BSlash>section{}<left>
	autocmd FileType tex :iabbrev ssec <BSlash>subsection{}<left>

	autocmd FileType tex setlocal spell spelllang=en_gb
augroup END

" }}}


" text file settings {{{

augroup filetype_text
	autocmd!
	autocmd FileType text setlocal spell spelllang=en_gb
	autocmd FileType text nnoremap <buffer> <leader>z z=
augroup END

" }}}


" Util settings {{{

augroup filetype_all
	autocmd!

	" Remove all trailing whitespace before writing the file
	autocmd BufWritePre * %s/\s\+$//e
	autocmd FileType * nnoremap <leader>l :Lex!<cr>
augroup END

function! InsertBracket()

	if (getline('.')[col('.') - 1] == '[')
		return "["
	else
		return "[]"
	endif

endfunction


function! InsertParenthesis()

	if (getline('.')[col('.') - 1] == '(')
		return "("
	else
		return "()"
	endif

endfunction


function! DeleteSingleOrDoubleQuotations()

	if (getline('.')[col('.') - 2] == '"' && getline('.')[col('.') - 1] == '"')
		return "\<bs>\<delete>"
	elseif(getline('.')[col('.')-2] == '"' && getline('.')[col('.')-3] == '"')
		return "\<bs>\<bs>"
	else
		return "\<bs>"
	endif

endfunction


function! DeleteBracketOrParenthesis()

	if (getline('.')[col('.')-2] == '[' && getline('.')[col('.')-1] == ']')
		return "\<bs>\<delete>"
	elseif(getline('.')[col('.')-2] == ']' && getline('.')[col('.')-3] == '[')
		return "\<bs>\<bs>"
	elseif(getline('.')[col('.')-2] == '(' && getline('.')[col('.')-1] == ')')
		return "\<bs>\<delete>"
	elseif(getline('.')[col('.')-2] == ')' && getline('.')[col('.')-3] == '(')
		return "\<bs>\<bs>"
	else
		return "\<bs>"
	endif

endfunction


function! Backspace()

	let curr_line = getline('.')
	let curr_char = getline('.')[col('.') - 2]


	if (curr_char == '"')
		return DeleteSingleOrDoubleQuotations()
	elseif (curr_char == '(' || curr_char == ')' || curr_char == '[' || curr_char == ']')
		return DeleteBracketOrParenthesis()
	endif


	return "\<bs>"

endfunction


inoremap [ <C-R>=InsertBracket()<cr><left>
inoremap ( <C-R>=InsertParenthesis()<cr><left>
inoremap <BS> <C-R>=Backspace()<cr>


" }}}


function! s:goyo_leave()
	" Set colors on Goyo leave otherwise they reset to defaults
	highlight ColorColumn guibg=#2b2b2b
	highlight Folded guibg=#2b2b2b
endfunction

autocmd! User GoyoLeave nested call <SID>goyo_leave()

