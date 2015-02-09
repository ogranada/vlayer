
" REQUIREMENTS
" apt-get install python-gst-1.0 python-gst0.10
" apt install gstreamer0.10-fluendo-mp3/testing
" apt install gstreamer1.0-fluendo-mp3/testing


if exists("g:vlayer_load_files")
    finish
endif
let g:vlayer_load_files = 1

function! vlayer#loadFiles()
    runtime lib/vlayer.vim
    runtime plugin/vlayer/ui_glue.vim
endfunction




