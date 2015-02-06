
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
    if os.path.isdir(path):
        import string
        import random
        valid_files = []
        for f in os.listdir(path):
            if f.lower().endswith(".mp3"):
                valid_files.append( path+os.sep+f )
        dest_file = "/tmp/__vlayer__" + str(os.getpid()) + ''.join(random.choice(string.ascii_uppercase) for i in range(12))+".sh"
        with open(dest_file, 'w') as repro:
            repro.write("#!/bin/bash\n\n")
            for vf in valid_files:
                repro.write("gst-launch playbin uri='file://%s' fakeval=pid_%s;\n"%(vf, str(os.getpid())))
        os.system("chmod +x "+dest_file)
        os.system("""nohup %s > /dev/null 2> /dev/null &"""%(dest_file))
    else:
        os.system("""nohup gst-launch playbin uri='file://%s' fakeval=pid_%s > /dev/null 2> /dev/null &"""%(path, str(os.getpid()) ))
    print "playing",path, os.getpid()
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


autocmd  VimLeave   :call vlayer#Stop()

