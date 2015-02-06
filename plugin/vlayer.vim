
" REQUIREMENTS
" apt-get install python-gst-1.0 python-gst0.10
" apt install gstreamer0.10-fluendo-mp3/testing
" apt install gstreamer1.0-fluendo-mp3/testing

function! vlayer#Play(path)
    "let ruta=a:path
    python << EOF

import vim
import os

try:
    path = vim.eval("a:path")
    if not path.startswith(os.sep):
        path = "."+os.sep+path
        path = os.path.abspath(path)
    if os.path.isdir(path):
        import string
        import random
        valid_files = []
        for f in os.listdir(path):
            if f.lower().endswith(".mp3"):
                valid_files.append( path+os.sep+f )
        dest_file = "/tmp/__vlayer__" + str(os.getpid()) + '__' + ''.join(random.choice(string.ascii_uppercase) for i in range(12))+".sh"
        with open(dest_file, 'w') as repro:
            repro.write("#!/bin/bash\n\n")
            for vf in valid_files:
                repro.write("gst-launch playbin uri='file://%s' fakeval=pid_%s;\n"%(vf, str(os.getpid())))
        os.system("chmod +x "+dest_file)
        os.system("""nohup %s > /dev/null 2> /dev/null &"""%(dest_file))
    else:
        print """nohup gst-launch playbin uri='file://%s' fakeval=pid_%s > /dev/null 2> /dev/null &"""%(path, str(os.getpid()) )
        os.system("""nohup gst-launch playbin uri='file://%s' fakeval=pid_%s > /dev/null 2> /dev/null &"""%(path, str(os.getpid()) ))
    print "playing",path
except Exception, e:
    print e

EOF
    " Here the python code is closed. We can continue writing VimL or python again.
endfunction

function! vlayer#Stop()
    "let ruta=a:path
    python << EOF

import vim
import os

try:
    os.system("""ps -Af | grep __vlayer__ | grep %s | grep -v grep | awk '{print $2}' | xargs kill > /dev/null 2> /dev/null """%( str(os.getpid()) ))
    os.system("""ps -Af | grep gst-launch | grep pid_%s | grep -v grep | awk '{print $2}' | xargs kill > /dev/null 2> /dev/null """%( str(os.getpid()) ))
    os.system("""ls /tmp/*%s* 2> /dev/null | xargs rm > /dev/null 2> /dev/null """%( str(os.getpid()) ))
    print "stopped..."
except Exception, e:
    print e

EOF
    " Here the python code is closed. We can continue writing VimL or python again.
endfunction

function! vlayer#Skip()
    "let ruta=a:path
    python << EOF

import vim
import os

try:
    os.system("""ps -Af | grep gst-launch | grep pid_%s | grep -v grep | awk '{print $2}' | xargs kill > /dev/null 2> /dev/null """%( str(os.getpid()) ))
    print "skipped..."
except Exception, e:
    print e

EOF
    " Here the python code is closed. We can continue writing VimL or python again.
endfunction

function! vlayer#Playing()
    "let ruta=a:path
    python << EOF

import vim
import os

try:
    ## TODO: implement playing now function...
except Exception, e:
    print e

EOF
    " Here the python code is closed. We can continue writing VimL or python again.
endfunction



autocmd  VimLeave   :call vlayer#Stop()


" command! -complete=file -nargs=1 Vplay :call vlayer#Play(<q-args>)
" command! -nargs=0 Vstop :call vlayer#Stop()
" command! -nargs=0 Vskip :call vlayer#Skip()

