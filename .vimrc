set fileformat=unix
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" NERDTree - File Explorer Plugin
Plug 'preservim/nerdtree'

" gruvbox - Vim Theam
Plug 'morhetz/gruvbox'

" vim-airline - status bas
Plug 'vim-airline/vim-airline'

" vim-fugitive - git bindings
Plug 'tpope/vim-fugitive'

" fzf - fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" vim wiki for personal notes
Plug 'vimwiki/vimwiki'

" Initialize plugin system
call plug#end()

" Grubbox settings
" set background=dark " setting dark mode for gruvbox
set background=light 

set rtp+=/usr/local/bin/fzf
set rtp+=~/.fzf/

"Auto Save
au TextChanged *
au InsertLeave *

autocmd vimenter * nested colorscheme gruvbox
syntax on
set number 
set relativenumber

set backupdir=~/tmp

"Search down into the sub directory
"Provide tab completeion for all file related tasks.
set path+=**
set nocompatible "No need to be compatile with Vi
set wildmenu     "Completion of commands
set wildignorecase   "Case insentive completion
set wildignore=*.git/*,*.tags,tags,*.o,*.class  "What to ignore in the completion

filetype plugin on "This is used for navigation


"Ctags
set tags=./tags;/ "This will look in current directory for tags file/go up the directory tree to find one.
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>   "Open Definition in a New Tab
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>      "Open Definition in New Vertical Split


"NERDTree Setting
"View Hidden Files
let NERDTreeShowHidden=1

filetype plugin indent on "This is used for file navigation
set backspace=indent,eol,start   "This is for Fixed indentation

"Go to the last active tab
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <C-l> :exe "tabn ".g:lasttab<CR>
vnoremap <silent> <C-l> :exe "tabn ".g:lasttab<CR>

" Mapped Leader Key to Space Bar
:let mapleader = " "

" Got to tab by number
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 :tablast<CR>

"Automatic Loading of CScope
function! LoadCscope()
	let db = findfile("cscope.out", ".;")
	if (!empty(db))
		let path = strpart(db, 0, match(db, "/cscope.out$"))
		set noscopeverbose 					"Suppress 'duplicate connection' error
		exe "cs add " . db . " " .path
		set scopeverbose

		"else add the databse pointer to by environment variable
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
endfunction

au BufEnter   /*  call LoadCscope()

set tabstop=4		" The width of a TAB is set to 4.
			" Still it is a \t. It is just that 
			" Vim will interpret it to have
			" a width of 4.

set shiftwidth=4        " Indent will have a width of 4

set softtabstop=4       " Sets the nubmer of colums for a TAB

"set expandtab          " Expand TABs to spaces
			" This can cause issues in make files


" Open Split in the right side
set splitright

set splitbelow


" TAG JUMPING:

"Create the 'tags' file (may need to intall ctags first)
command! MakeTags !ctags -R .


" Now We Can:
" Use ^] to jump to the tag under cursor
" Use g^] for ambiguous tags
" Use ^t to jump back up the tag stack


" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags

" FILE BROWSING:

" Tweaks for browsing
let g:netrw_banner=0		"disable annoying banner
let g:netrw_browse_split=4	"open in prior window
let g:netrw_altv=1		"open split to the right
let g:netrw_liststyle=3		"tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide=',\(^\|\s\s\)\zs\.\S\+'

" NOW WE CAN:
" - edit a folder to open a file browser
" - <CR>/v/t to open  in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings

" Enable sysntax highlighting for binary files
set ft=xxd

" Make the hidden buffer - edited buffer(not saved) which are not shown on a
" window
set hidden

" Confirm, if there is any hidden buffers before closing the buffer
set confirm

" Highlight the text found during search
set hlsearch

" Incremental Search, Search as you type
set incsearch

" Ignore Case During Search
set ignorecase

" Display the current curser position, row and column at bottom
set ruler

" Enable line wrapping at word boundary
set lbr

" Search for the word under the curser in the current directory
nnoremap <f5> :grep <cword> *<CR> 

" CUSTOM LEADER KEY MAPPING

" Source vimrc
nnoremap <leader>sop :source %<CR>

" Toggle Highlight
map <leader>h :noh<CR>

"Toggle NerdTree
map <leader>tt :NERDTreeToggle<CR>
map <leader>tr :NERDTreeFind<CR>

"Cscope.vim settings
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>lt :call ToggleLocationList()<CR>

" s: Find this C symbol
nnoremap <leader>fs :call CscopeFind('s', expand('<cword>))<CR>

" g: Find this definition
nnoremap <leader>fg :call CscopeFind('g', expand('<cword>))<CR>

" d: Find functions called by this function 
nnoremap <leader>fd :call CscopeFind('d', expand('<cword>))<CR>

" c: Find functions calling this function 
nnoremap <leader>fc :call CscopeFind('c', expand('<cword>))<CR>

" t: Find this text string
nnoremap <leader>ft :call CscopeFind('t', expand('<cword>))<CR>

" e: Find this egrep pattern
nnoremap <leader>fe :call CscopeFind('e', expand('<cword>))<CR>

" f: Find this file
nnoremap <leader>ff :call CscopeFind('f', expand('<cword>))<CR>

" i: Find files including this file
nnoremap <leader>in :call CscopeFind('i', expand('<cword>))<CR>

" END of Cscope.vim settings

" You Complete Me - Key Bindings
nnoremap <leader>gt :YcmCompleter GoTo<CR>

" This binding is conflicting with that of Cscope, so disabled.
" nnoremap <leader>gi :YcmCompleter FixIt<CR>

nnoremap <leader>gd :YcmCompleter GetDoc<CR>

nnoremap <leader>gtp :YcmCompleter GoTo<CR>

nnoremap <leader>gp :YcmCompleter GetParent<CR>

nnoremap <leader>gti :YcmCompleter GoToInclude<CR>

noremap <leader>gdf :YcmCompleter GoToDefinition<CR>

nnoremap <leader>gdc :YcmCompleter GoToDeclaration<CR>

nnoremap <leader>yd :YcmCompleter YcmDiags<CR>

" END OF You Complete Me - Key Bindings


" FZF - Key Bindings
nnoremap <leader>fi :Files<CR>

nnoremap <leader>bu :Buffers<CR>

nnoremap <leader>li :Lines<CR>

nnoremap <leader>bl :BLines<CR>

nnoremap <leader>wi :Windows<CR>

nnoremap <leader>hi :History<CR>

nnoremap <leader>ii :History/<CR>
" END OF FZF - Key Bindings

" Toggle quick fix list

function! ToggleQuickFix()
	if empty(filter(getwininfo(), 'v:val.quickfix'))
		copen
	else
		cclose
	endif
endfunction

nnoremap <leader>c :call ToggleQuickFix()<CR>

" Split Key Bindings
nnoremap <leader>vv <C-w>v
nnoremap <leader>vs <C-w>s
nnoremap <leader>vc <C-w>c
nnoremap <leader>v= <C-w>=
nnoremap <leader>vt :tabnew<CR>
nnoremap <leader>vd :tabclose<CR>

" Shell Binding
nnoremap <leader>tv :vert terminal<CR>
nnoremap <leader>ss :shell<CR>
nnoremap <leader>te :terminal<CR>

" Terminal Navigation
"tnoremap <C-h> <C-\><C-n><C-w>h
"tnoremap <C-l> <C-\><C-n><C-w>l
"tnoremap <C-j> <C-\><C-n><C-w>j
"tnoremap <C-k> <C-\><C-n><C-w>k

" Window Split Navigatin Key Bindings
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Start intractive EasyAlign for a motion/text object (eg. gaip)
xmap ga <Plug>(EasyAlign)

" Start interatvie EasyAlign for a motion/text object
nmap ga <Plug>(EasyAlign)

" Cycle through the buffers
" Next
nnoremap <C-n> :bn<CR>

" Previous
nnoremap <C-p> :bp<CR>

" Toggle Relative number and line number
nnoremap <leader> :set nu!<CR> :set rnu!<CR>

