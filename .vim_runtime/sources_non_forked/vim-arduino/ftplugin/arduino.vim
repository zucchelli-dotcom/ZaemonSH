if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1
if !exists('g:arduino_did_initialize')
  call arduino#LoadCache()
  call arduino#InitializeConfig()
  let g:arduino_did_initialize = 1
endif

" Use C rules for indentation
setl cindent

call arduino#RebuildMakePrg()

if g:arduino_auto_baud
  au BufReadPost,BufWritePost *.ino,*.pde call arduino#SetAutoBaud()
endif




""""""""""""""""
command! -buffer -bar -nargs=? ArduinoChooseBoard call arduino#ChooseBoard(<f-args>)
command! -buffer -bar -nargs=? ArduinoChooseProgrammer call arduino#ChooseProgrammer(<f-args>)
command! -buffer -bar ArduinoVerify call arduino#Verify()
command! -buffer -bar ArduinoUpload call arduino#Upload()
command! -buffer -bar ArduinoSerial call arduino#Serial()
command! -buffer -bar ArduinoUploadAndSerial call arduino#UploadAndSerial()
command! -buffer -bar -nargs=? ArduinoChoosePort call arduino#ChoosePort(<f-args>)


" To make easy use of these, you may want to bind them to a key combination. You
" can put the following in `.vim/ftplugin/arduino.vim`:

nnoremap <buffer> <leader>am :ArduinoVerify<CR>
nnoremap <buffer> <leader>au :ArduinoUpload<CR>
nnoremap <buffer> <leader>ad :ArduinoUploadAndSerial<CR>
nnoremap <buffer> <leader>ab :ArduinoChooseBoard<CR>
nnoremap <buffer> <leader>ap :ArduinoChooseProgrammer<CR>

" If you want to add the board type to your status line, it's easy with the following:

" " my_file.ino [arduino:avr:uno]
" function! b:MyStatusLine()
"   return '%f [' . g:arduino_board . ']'
" endfunction
" setl statusline=%!b:MyStatusLine()

" " Or if you want something a bit fancier that includes serial port info:

" " my_file.ino [arduino:avr:uno] [arduino:usbtinyisp] (/dev/ttyACM0:9600)
" function! b:MyStatusLine()
"   let port = arduino#GetPort()
"   let line = '%f [' . g:arduino_board . '] [' . g:arduino_programmer . ']'
"   if !empty(port)
"     let line = line . ' (' . port . ':' . g:arduino_serial_baud . ')'
"   endif
"   return line
" endfunction
" setl statusline=%!b:MyStatusLine()
