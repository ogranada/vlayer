


function! vlayer#Play(path)
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
    readme = vim.eval("g:vundle_readme")
    exe_path = os.sep.join( readme.split(os.sep)[0:-2] +
                            ["vlayer", "tools", "shell_player.py"]
                           )
    repro = exe_path if os.path.exists(exe_path) else "gst"
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
                if repro == "gst":
                    repro.write("gst-launch playbin uri='file://%s' fakeval=pid_%s;\n"%(vf, str(os.getpid())))
                else:
                    repro.write("%s '%s' fakeval=pid_%s;\n"%(repro, vf, str(os.getpid())))
        os.system("chmod +x "+dest_file)
        os.system("""nohup %s > /dev/null 2> /dev/null &"""%(dest_file))
    else:
        if repro == "gst":
            os.system("""nohup gst-launch playbin uri='%s' fakeval=pid_%s > /dev/null 2> /dev/null &"""%(path, str(os.getpid()) ))
        else:
            os.system("""nohup %s '%s' fakeval=pid_%s > /dev/null 2> /dev/null &"""%(repro, path, str(os.getpid()) ))
    print "playing",path
except Exception as e:
    print e

EOF
endfunction

function! vlayer#Stop()
    python << EOF

import vim
import os

try:
    readme = vim.eval("g:vundle_readme")
    exe_path = os.sep.join( readme.split(os.sep)[0:-2] +
                            ["vlayer", "tools", "shell_player.py"]
                           )
    repro = "shell_player.py" if os.path.exists(exe_path) else "gst-launch"
    os.system("""ps -Af | grep __vlayer__ | grep %s | grep -v grep | awk '{print $2}' | xargs kill > /dev/null 2> /dev/null """%( str(os.getpid()) ))
    os.system("""ps -Af | grep """ + repro + """ | grep pid_%s | grep -v grep | awk '{print $2}' | xargs kill > /dev/null 2> /dev/null """%( str(os.getpid()) ))
    os.system("""ls /tmp/*%s* 2> /dev/null | xargs rm > /dev/null 2> /dev/null """%( str(os.getpid()) ))
    print "stopped..."
except Exception as e:
    print e

EOF
endfunction

function! vlayer#Skip()
    python << EOF

import vim
import os

try:
    readme = vim.eval("g:vundle_readme")
    exe_path = os.sep.join( readme.split(os.sep)[0:-2] +
                            ["vlayer", "tools", "shell_player.py"]
                           )
    repro = "shell_player.py" if os.path.exists(exe_path) else "gst-launch"
    os.system("""ps -Af | grep """ + repro + """ | grep pid_%s | grep -v grep | awk '{print $2}' | xargs kill > /dev/null 2> /dev/null """%( str(os.getpid()) ))
    print "skipped..."
except Exception as e:
    print e

EOF
endfunction

function! vlayer#Playing()
    python << EOF

import vim
import os

try:
    ## TODO: implement playing now function...
except Exception as e:
    print e

EOF
endfunction


function! vlayer#Pause()
    python << EOF

import vim
import os

try:
    os.system('''ps -Af | grep shell_player | grep pid_%s | grep -v grep | awk '{print $2}' | xargs kill -s SIGBUS '''%( str(os.getpid()) ))
except Exception as e:
    print e

EOF
endfunction

function! vlayer#Unpause()
    python << EOF

import vim
import os

try:
    os.system('''ps -Af | grep shell_player | grep pid_%s | grep -v grep | awk '{print $2}' | xargs kill -s SIGURG '''%( str(os.getpid()) ))
except Exception as e:
    print e

EOF
endfunction

function! vlayer#SwapPause()
    python << EOF

import vim
import os

try:
    os.system('''ps -Af | grep shell_player | grep pid_%s | grep -v grep | awk '{print $2}' | xargs kill -s SIGALRM '''%( str(os.getpid()) ))
except Exception as e:
    print e

EOF
endfunction







