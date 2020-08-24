"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Important:
"       This requries that you install https://github.com/amix/vimrc !
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" => Load pathogen paths
""""""""""""""""""""""""""""""
let s:vim_runtime = expand('<sfile>:p:h')."/.."
call pathogen#infect(s:vim_runtime.'/sources_forked/{}')
call pathogen#infect(s:vim_runtime.'/sources_non_forked/{}')
call pathogen#infect(s:vim_runtime.'/my_plugins/{}')
call pathogen#helptags()

""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0         
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>


""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>


""""""""""""""""""""""""""""""
" => YankStack
""""""""""""""""""""""""""""""
let g:yankstack_yank_keys = ['y', 'd']
nmap <c-p> <Plug>yankstack_substitute_older_paste
nmap <c-n> <Plug>yankstack_substitute_newer_paste


""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0

let g:ctrlp_map = '<c-f>'
map <leader>j :CtrlP<cr>
map <c-b> :CtrlPBuffer<cr>

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'


""""""""""""""""""""""""""""""
" => ZenCoding
""""""""""""""""""""""""""""""
" Enable all functions in all modes
let g:user_zen_mode='a'


""""""""""""""""""""""""""""""
" => snipMate (beside <TAB> support <CTRL-j>)
""""""""""""""""""""""""""""""
ino <c-j> <c-r>=snipMate#TriggerSnippet()<cr>
snor <c-j> <esc>i<right><c-r>=snipMate#TriggerSnippet()<cr>


""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <C-n> :NERDTreeToggle<CR>
" map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>
"" " NERDTree
"
"
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"
autocmd StdinReadPre * let s:std_in=0
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) &&  !exists("s:std_in") | exe 'NERDTree' argv()[0]  | wincmd p | ene | exe'cd ' argv()[0] | endif
"
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && NERDTreeisTabTree()) | q |  endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-s>'
let g:multi_cursor_select_all_word_key = '<A-s>'
let g:multi_cursor_start_key           = 'g<C-s>'
let g:multi_cursor_select_all_key      = 'g<A-s>'
let g:multi_cursor_next_key            = '<C-s>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => surround.vim config
" Annotate strings with gettext 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:lightline = {
"       \ 'colorscheme': 'wombat',
"       \ }

" let g:lightline = {
"       \ 'colorscheme': 'wombat',
"       \ 'active': {
"       \   'left': [ ['mode', 'paste'],
"       \             ['fugitive', 'readonly', 'filename', 'modified'] ],
"       \   'right': [ [ 'lineinfo' ], ['percent'] ]
"       \ },
"       \ 'component': {
"       \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
"       \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
"       \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
"       \ },
"       \ 'component_visible_condition': {
"       \   'readonly': '(&filetype!="help"&& &readonly)',
"       \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
"       \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
"       \ },
"       \ 'separator': { 'left': ' ', 'right': ' ' },
"       \ 'subseparator': { 'left': ' ', 'right': ' ' }
"       \ }

" " " LightLine
" " 1. Register the components:
"  let g:lightline = {}
"  let g:lightline.component_expand = {
"        \  'linter_checking': 'lightline#ale#checking',
"        \  'linter_warnings': 'lightline#ale#warnings',
"        \  'linter_errors': 'lightline#ale#errors',
"        \  'linter_ok': 'lightline#ale#ok',
"         \ }
"  " 2. Set color to the components:
"  let g:lightline.component_type = {
"        \     'linter_checking': 'left',
"        \     'linter_warnings': 'warning',
"        \     'linter_errors': 'error',
"        \     'linter_ok': 'left',
"        \ }
"  " 3. Add the components to the lightline, for example to the right side:
"  let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]]  }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vimroom
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_fmt_command = "goimports"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntastic (syntax checker)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_linters = {
\   'javascript': ['jshint'],
\   'python': ['flake8'],
\   'go': ['go', 'golint', 'errcheck']
\}

nmap <silent> <leader>a <Plug>(ale_next_wrap)

" Disabling highlighting
let g:ale_set_highlights = 0

" Only run linting when saving the file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git gutter (Git diff)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_enabled=0
nnoremap <silent> <leader>d :GitGutterToggle<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VimPluG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""" " let g:vim_markdown_folding_disabled=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Arduino
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " " nnoremap <buffer> <leader>am :ArduinoVerify<CR>
" nnoremap <buffer> <leader>au :ArduinoUpload<CR>
" nnoremap <buffer> <leader>ad :ArduinoUploadAndSerial<CR>
" nnoremap <buffer> <leader>ab :ArduinoChooseBoard<CR>
" nnoremap <buffer> <leader>ap :ArduinoChooseProgrammer<CR>
"" If you want to add the board type to your status line, it's easy with the
" following:
"" vim
" " my_file.ino [arduino:avr:uno]
" function! b:MyStatusLine()
"   return '%f [' . g:arduino_board . ']'
" endfunction
" setl statusline=%!b:MyStatusLine()
" ```
"" if you want something a bit fancier that includes serial port info:
" my_file.ino [arduino:avr:uno] [arduino:usbtinyisp] (/dev/ttyACM0:9600)
" function! b:MyStatusLine()
"   let port = arduino#GetPort()
"   let line = '%f [' . g:arduino_board . '] [' . g:arduino_programmer . ']'
"   if !empty(port)
"     let line = line . ' (' . port . ':' . g:arduino_serial_baud . ')'
"   endif
"   return line
" endfunction
" setl statusline=%!b:MyStatusLine()
"
"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => WindowSwap
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" " let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim run-interactive 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>ri :RunInInteractiveShell<space>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-zsh-completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The script is set as omnicompletion (^X^O) for zsh files automatically. It
" plays well with YouCompleteMe from what I have seen, although it needs to be
" manually triggered like most semantic completions.
" You can also bind it to user completion (^X^U) for use outside of zsh script
" files using:
" set completefunc=zsh_completion#Complete


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""  Automatically displays all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1
" let g:airline_powerline_fonts = 1
" let g:airline_symbols_ascii = 1
let g:airline_mode_map = {
       \ '__' : '-',
       \ 'n'  : 'N',
       \ 'i'  : 'I',
       \ 'R'  : 'R',
       \ 'c'  : 'C',
       \ 'v'  : 'V',
       \ 'V'  : 'V',
       \ '^V' : 'V',
       \ 's'  : 'S',
       \ 'S'  : 'S',
       \ '^S' : 'S',
       \ }
""" Separators can be configured independently for the tabline, so here is how you can define straight tabs
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
" let g:airline#extensions#tabline#formatter = 'default'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline Themes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" " Airline Themes
let g:airline_theme='term'



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VimDevIcons
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set guifont=DroidSansMono_Nerd_Font:h9
" loading the plugin
" let g:webdevicons_enable = 1
" adding the flags to NERDTree
let g:webdevicons_enable_nerdtree = 1
" adding to vim-airline's tabline
let g:webdevicons_enable_airline_tabline = 1
" adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 1
" ctrlp glyphs
let g:webdevicons_enable_ctrlp = 1
" enable folder/directory glyph flag (disabled by default with 0)
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" enable open and close folder/directory glyph flags (disabled by default with 0)
let g:DevIconsEnableFoldersOpenClose = 1
" use double-width(1) or single-width(0) glyphs
" only manipulates padding, has no effect on terminal or set(guifont) font
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
" enable file extension pattern matching glyphs on folder/directory (disabled by default with 0)
let g:DevIconsEnableFolderExtensionPatternMatching = 1
" specify OS to decide an icon for unix fileformat (not defined by default)
" this is useful for avoiding uunnecessary nnecessary system() call. see #135 for further details.
 if has("mac") || has("macunix")
    let g:WebDevIconsOS = 'Darwin'
 " elseif has("linux")
 "    let g:WebDevIconsOS = 'Linux'
 endif

