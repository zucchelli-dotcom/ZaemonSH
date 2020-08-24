"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Zucchelli Bryan.
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Set font according to system
if has("mac") || has("macunix")
    set gfn=IBM\ Plex\ Mono:h14,Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
elseif has("win16") || has("win32")
    set gfn=IBM\ Plex\ Mono:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("gui_gtk2")
    set gfn=IBM\ Plex\ Mono:h14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("linux")
    set gfn=IBM\ Plex\ Mono:h14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("unix")
    set gfn=Monospace\ 11
endif


" Disable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" "" " Set Fonts
" " set encoding=utf8
" " set guifont=Menio:h10,Arial:h10
" if has("mac") || has("macunix")
"     set guifont=DroidSansMono_Nerd_Font:h12
" elseif has("linux")
"     set guifont=DroidSansMono\ Nerd\ Font\ 12
" endif

" Colorscheme
set background=dark
colorscheme badwolf
" colorscheme busybee
" let g:sierra_Pitch = 1
" let g:sierra_Midnight = 1
" colorscheme sierra


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fast editing and reloading of vimrc configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map <leader>e :e! ~/.vim_runtime/my_configs.vim<cr>
" autocmd! bufwritepost ~/.vim_runtime/my_configs.vim source ~/.vim_runtime/my_configs.vim


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on 
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
" it deletes everything until the last slash 
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Map ½ to something useful
map ½ $
cmap ½ $
imap ½ $


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Omni complete functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType css set omnifunc=csscomplete#CompleteCSS



autocmd FileType zsh set omnifunc=zshcomplete#Completezsh


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ack searching and cope displaying
"    requires ack.vim - it's much better than vimgrep/grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use the the_silver_searcher if possible (much faster than Ack)
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif

" When you press gv you Ack after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ack and put the cursor in the right position
map <leader>g :Ack 

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with Ack, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" The trick is to add commands for saving a session when quitting Vim, and restoring
" the session when opening Vim. This way you can open and close Vim without losing
" the settings, a list of open files, and so on. You can do this by simply adding the
" following commands to your vimrc file:

" autocmd VimEnter * call LoadSession()
" autocmd VimLeave * call SaveSession()
" function! SaveSession()
"     execute 'mksession! $HOME/.vim_runtime/sessions/session.vim'
" endfunction
" function! LoadSession()
"     if argc() == 0
"         execute 'source $HOME/.vim_runtime/sessions/session.vim'
"     endif
" endfunction

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

"Insert the date at the end
 function DateInsert()
     $read  !date
     Commentary
 endfunction

 map <F12> :call DateInsert()<CR>\| :write<CR>

 " if has("autocmd")
     autocmd FileWritePre * :call DateInsert()<CR>
 " endif

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

func! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif   

    return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" Strip trailing whitespace (,ss)
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function! GetGitBranchName()

    let branchName = ''

    if exists('g:loaded_fugitive')
        let branchName = '[' . fugitive#head() . ']'
    endif

    return branchName

endfunction

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function! StripTrailingWhitespaces()

    " Save last search and cursor position
    let searchHistory = @/
    let cursorLine = line('.')
    let cursorColumn = col('.')

    " Strip trailing whitespaces
    %s/\s\+$//e

    " Restore previous search history and cursor position
    let @/ = searchHistory
    call cursor(cursorLine, cursorColumn)

endfunction

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function! ToggleLimits()

    " [51,73]
    "   - git commit message
    "     http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
    " [81]
    "   - general use

    if ( &colorcolumn == '73' )
        set colorcolumn+=51,81
    else
        set colorcolumn-=51,81
    endif

endfunction

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function! ToggleRelativeLineNumbers()

    if ( &relativenumber == 1 )
        set number
    else
        set relativenumber
    endif

endfunction


" ----------------------------------------------------------------------
" | Automatic Commands                                                 |
" ----------------------------------------------------------------------

if has('autocmd')
    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    " Automatically reload the configurations from the
    " `~/.vimrc` and `~/.gvimrc` files whenever they are changed
    augroup auto_reload_vim_configs

        autocmd!
        autocmd BufWritePost vimrc source $MYVIMRC

        if has('gui_running')
            autocmd BufWritePost gvimrc source $MYGVIMRC
        endif

    augroup END

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    " Use relative line numbers
    " http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/
    " augroup relative_line_numbers

    "     autocmd!

    "     " Automatically switch to absolute line numbers when vim loses focus
    "     autocmd FocusLost * :set number

    "     " Automatically switch to relative line numbers when vim gains focus
    "     autocmd FocusGained * :set relativenumber

    "     " Automatically switch to absolute line numbers when vim is in insert mode
    "     autocmd InsertEnter * :set number

    "     " Automatically switch to relative line numbers when vim is in normal mode
    "     autocmd InsertLeave * :set relativenumber

    " augroup END

     " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
     " Use  line numbers just in normal mode
     augroup line_numbers

         autocmd!

     "     " Automatically switch to absolute line numbers when vim loses focus
         autocmd FocusLost * :set nonumber

     "     " Automatically switch to relative line numbers when vim gains focus
         autocmd FocusGained * :set number
         autocmd FocusGained * :set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
         autocmd FocusGained * :set list

     "     " Automatically switch to absolute line numbers when vim is in insert mode
     "
         autocmd InsertEnter * :set number
        autocmd FocusGained * :set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
         autocmd FocusGained * :set list

         " Automatically switch to relative line numbers when vim is in normal mode
         autocmd InsertLeave * :set nonumber
                  

     augroup END


    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    " Automatically strip the trailing whitespaces when files are saved
    augroup strip_trailing_whitespaces

        " List of file types that use the trailing whitespaces:
        "
        "  * Markdown (mkd)
        "    https://daringfireball.net/projects/markdown/syntax#block

        let excludedFileTypes = [ 'mkd' ]

        " Only strip the trailing whitespaces if the file type
        " is not in the excluded file types list

        if index(excludedFileTypes, &filetype) != -1
            autocmd!
            autocmd BufWritePre * :call StripTrailingWhitespaces()
        endif

    augroup END

endif




" Automatic commands
if has("autocmd")
    " Enable file type detection
    filetype on
endif
