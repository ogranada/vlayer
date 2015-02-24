#!/usr/bin/env python
import os
import sys
import gst
import gobject

global FORMAT


class tag_getter:
    def __init__(self):
        # make a dictionary to hold our tag info
        self.file_tags = {}
        # make a playbin to parse the audio file
        self.pbin = gst.element_factory_make("playbin")
        # we need to receive signals from the playbin's bus
        self.bus = self.pbin.get_bus()
        # make sure we are watching the signals on the bus
        self.bus.add_signal_watch()
        # what do we do when a tag is part of the bus signal?
        self.bus.connect("message::tag", self.bus_message_tag)
        # create a loop to control our app
        self.mainloop = gobject.MainLoop()

    def bus_message_tag(self, bus, message):
        # we received a tag message
        taglist = message.parse_tag()
        # put the keys in the dictionary
        for key in taglist.keys():
            self.file_tags[key] = taglist[key]
        # for this test, if we have the artist tag, we can quit
        if self.file_tags['artist']:
            global FORMAT
            try:
                print FORMAT.format(**self.file_tags)
            except Exception as e:
                print self.file_tags
            sys.exit()

    def set_file(self, file):
        # set the uri of the playbin to our audio file
        self.pbin.set_property("uri","file://"+file)
        # pause the playbin, we don't really need to play
        self.pbin.set_state(gst.STATE_PAUSED)

    def run(self):
        # start the main loop
        self.mainloop.run()

if __name__=="__main__":
    if len(sys.argv)>1:
        file = sys.argv[1]
        global FORMAT
        if "--format" in sys.argv:
            FORMAT = sys.argv[sys.argv.index("--format")+1]
        else:
            FORMAT = "{artist} - {title}"
        pwd = os.getcwd()
        filepath = os.path.join(pwd,file)
        getter = tag_getter()
        getter.set_file(file)
        getter.run()

    else:
        print "select an audio file"
