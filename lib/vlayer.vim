


function! vlayer#Play(path)
    "let ruta=a:path
    python << EOF

import vim
import os
from urlparse import urlparse

try:
    path = vim.eval("a:path")
    if not ("http://" in path or "https://" in path):
        if not path.startswith(os.sep):
            path = "."+os.sep+path
            path = os.path.abspath(path)
            path = "file://"+path
    else:
        path = urlparse(path).geturl()
    if os.path.isdir(path):
        import string
        import random
        valid_files = []
        for f in os.listdir(path):
            ext = f.lower().split(".")[-1]
            if ext in "mp3 ogg".split():
                valid_files.append( path+os.sep+f )
        dest_file = "/tmp/__vlayer__" + str(os.getpid()) + '__' + ''.join(random.choice(string.ascii_uppercase) for i in range(12))+".sh"
        with open(dest_file, 'w') as repro:
            repro.write("#!/bin/bash\n\n")
            for vf in valid_files:
                repro.write("gst-launch playbin uri='file://%s' fakeval=pid_%s;\n"%(vf, str(os.getpid())))
        os.system("chmod +x "+dest_file)
        os.system("""nohup %s > /dev/null 2> /dev/null &"""%(dest_file))
    else:
        os.system("""nohup gst-launch playbin uri='%s' fakeval=pid_%s > /dev/null 2> /dev/null &"""%(path, str(os.getpid()) ))
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





