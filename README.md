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
## TO DO
* Make pause action  ```DOING```
* Make current playing action  ```TO DO```



