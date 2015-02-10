Vlayer
======
Vim simple music player plugin.

## Author
Oscar Andrés Granada [@oagranada](http://twitter.com/oagranada)

## Install 
### Before you start
Install gstreamer tools, in debian systems use apt:
```bash
apt-get install python-gst-1.0 python-gst0.10 gstreamer0.10-fluendo-mp3 gstreamer1.0-fluendo-mp3
```
### Instalation
You can use Vundle to install it:
```vim
" Put the next line in your .vimrc file
Bundle 'ogranada/vlayer' 
```

## Usage
Play a single file or a entire folder with Vplay:
```vim
:Vplay /home/user/Music/testfile.ogg
" Or "
:Vplay /home/user/Music/folder
```
You can play web media files especifying the protocol
```vim
:Vplay http://upload.wikimedia.org/wikipedia/commons/4/40/Elephant_voice_-_trumpeting.ogg
:Vplay http://listen.radionomy.com/Thrash-Zone-Radio
```
You can stop the actual reproduction
```vim
:Vstop
```
If you playing a folder you can skip the current track 
```vim
:Vskip
```
If you want pause the current track 
```vim
:Vpause
:Vp " swap the pause state
```
If you want play the current paused track 
```vim
:Vunpause
:Vp " swap the pause state
```

## TO DO
* Make current playing action  ```TO DO```


## License
The content of this project itself is licensed under the
[Creative Commons Attribution 3.0 license](http://creativecommons.org/licenses/by/3.0/us/deed.en_US),
and the underlying source code used to format and display that content
is licensed under the [MIT license](http://opensource.org/licenses/mit-license.php).

