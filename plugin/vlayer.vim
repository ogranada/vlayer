

if exists("g:loaded_vlayer_autoload")
    finish
endif
let g:loaded_vlayer_autoload = 1


call vlayer#loadFiles()
call vlayer#ui_glue#setupCommands()
autocmd  VimLeave   :call vlayer#Stop()





