

if exists("g:loaded_vlayer_ui_glue_autoload")
    finish
endif
let g:loaded_vlayer_ui_glue_autoload = 1

function! vlayer#ui_glue#setupCommands()
    command! -complete=file -nargs=1 Vplay :call vlayer#Play(<q-args>)
    command! -nargs=0 Vstop :call vlayer#Stop()
    command! -nargs=0 Vskip :call vlayer#Skip()
endfunction


