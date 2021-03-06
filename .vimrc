source ~/.vim/plugins.vim

" File type detection
filetype plugin indent on

" Colours and syntax highlighting options
syntax on
set t_Co=256
set background=dark
colorscheme princess
let g:molokai_original=1
let g:rehash256 = 1

highlight Comment cterm=italic
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%101v.\+/

" Set leaders
let mapleader = ","
let maplocalleader = "\\"

" Local dirs
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo
" Do I really need swap/backup/undo?
set noswapfile
set nobackup
set nowritebackup

" Indentation
set autoindent " Copy indent from last line when starting new line.
set softtabstop=2 " Tab key results in 2 spaces
set tabstop=2
set shiftwidth=2 " The # of spaces for indenting.
set expandtab " Expand tabs to spaces
set smarttab " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces.

" Folding
set nofoldenable
set foldcolumn=1 " Column to show folds
set foldlevel=20
set foldlevelstart=20 " Sets `foldlevel` when editing a new buffer
set foldmethod=syntax " Markers are used to specify folds.
set foldminlines=0 " Allow folding single lines
set foldnestmax=3 " Set max fold nesting level

" Quickfix Window Auto-open
augroup nested_window_auto_open
  autocmd!
  autocmd QuickFixCmdPost [^l]* nested cwindow 5
  autocmd QuickFixCmdPost    l* nested lwindow 5
augroup END
" Quickfix Window Close (,qq)
noremap <leader>qq :cclose<CR>

" Set some junk
set backspace=indent,eol,start
set cursorline " Highlight current line
set diffopt=filler " Add vertical spaces to keep right and left aligned
set diffopt+=iwhite " Ignore whitespace changes (focus on code changes)
set diffopt+=vertical " Vertical splits for diff
set encoding=utf-8 nobomb " BOM often causes trouble
set esckeys " Allow cursor keys in insert mode.
set formatoptions=
set formatoptions+=c " Format comments
set formatoptions+=r " Continue comments by default
set formatoptions+=o " Make comment when using o or O from comment line
set formatoptions+=q " Format comments with gq
set formatoptions+=n " Recognize numbered lists
set formatoptions+=2 " Use indent from 2nd line of a paragraph
set formatoptions+=l " Don't break lines that are already long
set formatoptions+=1 " Break before 1-letter words
set formatoptions+=t " Auto-wrapping
set gdefault " By default add g flag to search/replace. Add g to toggle.
set hidden " When a buffer is brought to foreground, remember undo history and marks.
set history=1000 " Increase history from 20 default to 1000
set hlsearch " Highlight searches
set ignorecase " Ignore case of searches.
set incsearch " Highlight dynamically as pattern is typed.
set laststatus=2 " Always show status line
set lispwords+=defroutes " Compojure
set lispwords+=defpartial,defpage " Noir core
set lispwords+=defaction,deffilter,defview,defsection " Ciste core
set lispwords+=describe,it " Speclj TDD/BDD
set magic " Enable extended regexes.
set mouse=a " Enable mouse in all modes.
set ttymouse=xterm2 " So mouse can work properly in vmux
set noerrorbells " Disable error bells.
set nojoinspaces " Only insert single space after a '.', '?' and '!' with a join command.
set nostartofline " Don't reset cursor to start of line when moving around.
set nowrap " Do not wrap lines.
set nu " Enable line numbers.
set ofu=syntaxcomplete#Complete " Set omni-completion method.
set report=0 " Show all changes.
set ruler " Show the cursor position
set scrolloff=10 " Start scrolling ten lines before horizontal border of window.
set shortmess=atI " Don't show the intro message when starting vim.
set showmode " Show the current mode.
set showtabline=2 " Always show tab bar.
set sidescrolloff=10 " Start scrolling three columns before vertical border of window.
set sidescroll=1 " Scroll 1 col at a time
set smartcase " Ignore 'ignorecase' if search patter contains uppercase characters.
set splitbelow " New window goes below
set splitright " New windows goes right
set suffixes=.bak,~,.swp,.swo,.o,.d,.info,.aux,.log,.dvi,.pdf,.bin,.bbl,.blg,.brf,.cb,.dmg,.exe,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyd,.dll
set title " Show the filename in the window titlebar.
set ttyfast " Send more characters at a given time.
set undofile " Persistent Undo.
set visualbell " Use visual bell instead of audible bell (annnnnoying)
set wildchar=<TAB> " Character for CLI expansion (TAB-completion).
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js,.DS_Store
set wildmenu " Hitting TAB in command mode will show possible completions above command line.
set wildmode=list:longest " Complete only until point of ambiguity.
set winminheight=0 "Allow splits to be reduced to a single line.
set wrapscan " Searches wrap around end of file

set clipboard=unnamed " Share clipboard

" ==============================================================================
" Custom scripts and shit
" ==============================================================================

" Auto read, and auto-actually-update file changes
set autoread
augroup auto_read
  autocmd!
  autocmd FocusGained,BufEnter * :silent! !
augroup END

" Better split switching (Ctrl-j, Ctrl-k, Ctrl-h, Ctrl-l)
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l

" Quick alternate buffer switching (,,)
" FIXME: Not working, conflicting with easymotion
noremap <leader>, <C-^>

" Toggle show tabs and trailing spaces (,c)
set list
set lcs=tab:›\ ,trail:·,nbsp:_,extends:…,precedes:…

set fcs=fold:-
nnoremap <silent> <leader>c :set nolist!<CR>

" Strip trailing whitespace (,ss)
function! StripWhitespace ()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <silent> <leader>ss :call StripWhitespace ()<CR>

" Restore cursor position
augroup cursor_restore
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup END

" Auto-open Quickfix window
augroup open_quickfix_window
  autocmd!
  autocmd QuickFixCmdPost * nested cwindow 5
augroup END

" Set relative line numbers
set relativenumber " Use relative line numbers. Current line is still in status bar.
augroup relative_line_numbers
  autocmd!
  autocmd BufReadPost,BufNewFile * set relativenumber
augroup END
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

" Applescript
augroup applescript_au
  autocmd!
  autocmd BufNewFile,BufRead *.applescript setf applescript
augroup END

" Files specifically with tabs
augroup files_with_tabs
  autocmd!
  autocmd BufNewFile,BufRead *.snippets setl noexpandtab
  autocmd BufNewFile,BufRead *.gitconfig setl noexpandtab
augroup END

" The number of times this has got me!
com! W w
com! Q q

" Mode-aware Cursor Highlighting (GUI Only)
set gcr=a:block

set gcr+=o:hor50-Cursor
set gcr+=n:Cursor
set gcr+=i-ci-sm:InsertCursor-hor10
set gcr+=r-cr:ReplaceCursor-hor20
set gcr+=c:CommandCursor
set gcr+=v-ve:VisualCursor
set gcr+=a:blinkon0

hi InsertCursor  ctermfg=15 guifg=#fdf6e3 ctermbg=37  guibg=#2aa198
hi VisualCursor  ctermfg=15 guifg=#fdf6e3 ctermbg=125 guibg=#d33682
hi ReplaceCursor ctermfg=15 guifg=#fdf6e3 ctermbg=65  guibg=#dc322f
hi CommandCursor ctermfg=15 guifg=#fdf6e3 ctermbg=166 guibg=#cb4b16

" Quickly edit me
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Map Y to act like D and C, Yank til EOL
noremap Y y$

" New file under string
" nnoremap <leader>v :call NewFileAt()<cr>
" function! NewFileAt ()
"   " lcd %:p:h
"   normal! vi'ay
"   echom "new file " . @a
" endfunction

" Home motion toggle
" http://ddrscott.github.io/blog/2016/vim-toggle-movement/
function! ToggleMovement(firstOp, thenOp)
  let pos = getpos('.')
  execute "normal! " . a:firstOp
  if pos == getpos('.')
    execute "normal! " . a:thenOp
  endif
endfunction
nnoremap <silent> 0 :call ToggleMovement('^', '0')<CR>

" Center the view if n/N moves out of view
function! s:nice_next(cmd)
  let view = winsaveview()
  execute "normal! " . a:cmd
  if view.topline != winsaveview().topline
    normal! zz
  endif
endfunction

nnoremap <silent> n :call <SID>nice_next('n')<cr>
nnoremap <silent> N :call <SID>nice_next('N')<cr>

" Custom Status Line
function! WindowNumber()
  return tabpagewinnr(tabpagenr())
endfunction
function! TrailingSpaceWarning()
  if !exists("b:statline_trailing_space_warning")
    let lineno = search('\s$', 'nw')
    if lineno != 0
      let b:statline_trailing_space_warning = '[trailing:'.lineno.']'
    else
      let b:statline_trailing_space_warning = ''
    endif
  endif
  return b:statline_trailing_space_warning
endfunction

function! ReadOnlyIcon()
  if &readonly
    return "🔒"
  else
    return ""
  endif
endfunction

" recalculate when idle, and after saving
augroup statline_trail
  autocmd!
  autocmd cursorhold,bufwritepost * unlet! b:statline_trailing_space_warning
augroup END

" hi clear StatusLine
" hi clear StatusLineNC
" hi StatusLine   term=bold cterm=bold ctermfg=White ctermbg=235
" hi StatusLineNC term=bold cterm=bold ctermfg=White ctermbg=235

" " highlight values in terminal vim, colorscheme solarized
" hi User1                      ctermfg=4          guifg=#40ffff            " Identifier
" hi User2                      ctermfg=2 gui=bold guifg=#ffff60            " Statement
" hi User3 term=bold cterm=bold ctermfg=1          guifg=White   guibg=Red  " Error
" hi User4                      ctermfg=1          guifg=Orange             " Special
" hi User5                      ctermfg=10         guifg=#80a0ff            " Comment
" hi User6 term=bold cterm=bold ctermfg=1          guifg=Red                " WarningMsg

" set statusline=
" set statusline+=\ %{ReadOnlyIcon()}
" set statusline+=\ 
" set statusline+=%5*%{expand('%:h')}/               " relative path to file's directory
" set statusline+=%1*%t%*                            " file name
" set statusline+=\ 
" set statusline+=\ 
" set statusline+=%<                                 " truncate here if needed
" set statusline+=%5*%L\ lines%*                     " number of lines
" set statusline+=\ 
" set statusline+=\ 
" set statusline+=%3*%{TrailingSpaceWarning()}%*     " trailing whitespace

" set statusline+=%=                                 " switch to RHS

" set statusline+=%5*col:%-3.c%*                      " column
" set statusline+=\ 
" set statusline+=\ 
" set statusline+=%2*buf:%-3n%*                      " buffer number
" set statusline+=\ 
" set statusline+=\ 
" set statusline+=%2*win:%-3.3{WindowNumber()}%*     " window number

nnoremap <leader>k :Lex<cr>

" ==============================================================================
" Plugin Configuration
" ==============================================================================

" CtrlP
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 400
let g:ctrlp_custom_ignore = '\v[\/](\.git|node_modules)$'
let g:ctrlp_switch_buffer = 'e'
let g:ctrlp_show_hidden = 1


" Syntastic
let g:syntastic_error_symbol = '⨉'
let g:syntastic_warning_symbol = '!'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = []
let g:syntastic_json_checkers = ['jsonlint']

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 3
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

if &diff
  let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
endif

" Emmet
let g:user_emmet_leader_key='<C-Z>'

" OmniSharp
augroup omnisharp_commands
  autocmd!
  autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
  autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
  autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
augroup END
nnoremap <leader>tp :OmniSharpAddToProject<cr>

" JSON Formatting
com! FormatJSON %!python -m json.tool

" HTML Formatting
com! FormatHTML %!tidy -iq -xml -wrap 0

" Airline
let g:airline_powerline_fonts = 1

" YouCompleteMe
let g:ycm_key_list_select_completion=['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-k>', '<Up>']
let g:ycm_autoclose_preview_window_after_completion=1
if !exists("g:ycm_semantic_triggers")
   let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
let g:ycm_semantic_triggers['css'] = ['  ', ': ']

" UltiSnips
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" Ag
let g:ag_working_path_mode="r"

" BufExplorer
let g:bufExplorerShowDirectories=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerSplitRight=0

" Tern
augroup tern_commands
  autocmd!
  autocmd FileType javascript noremap gd :TernDef<cr>
augroup END

" Vimux
noremap <Leader>vp :VimuxPromptCommand<CR>
noremap <Leader>vl :VimuxRunLastCommand<CR>

" Terminus
let g:TerminusInsertCursorShape=2

" TypeScript
augroup typescript_commands
  autocmd!
  autocmd FileType typescript call s:typescript_filetype_settings()
  autocmd FileType typescript noremap gd :TsuDefinition<cr>
augroup END
function! s:typescript_filetype_settings()
  set makeprg=tsc
endfunction

" EasyMotion
" FIXME: EasyMotion steals my leader-leader quick switch
" map <Leader> <Plug>(easymotion-prefix)
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" Incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Incsearch - noh after motion
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" fzf
inoremap <expr> <c-x><c-k> fzf#complete('cat /usr/share/dict/words')
noremap <C-p> :Files<cr>

" JSX Helpers
augroup jsx_helpers
  autocmd!
  autocmd FileType javascript nnoremap <leader>ja :call JSXEncloseReturn()<CR>
  autocmd FileType javascript nnoremap <leader>ji :call JSXEachAttributeInLine()<CR>
  autocmd FileType javascript nnoremap <leader>ve :call JSXExtractPartialPrompt()<CR>
  autocmd FileType javascript nnoremap <leader>jc :call JSXChangeTagPrompt()<CR>
  autocmd FileType javascript nnoremap vat :call JSXSelectTag()<CR>
augroup END

" CSS completion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci

" Emoji
if emoji#available()
  let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
  let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
  let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
  let g:gitgutter_sign_modified_removed = emoji#for('collision')
endif

set completefunc=emoji#complete

