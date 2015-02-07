#!/usr/bin/python
# -*- coding:utf-8 -*-

import pygst
import sys
pygst.require("0.10")
import gst
import urlparse
import urllib
import signal


def path2url(path):
    return urlparse.urljoin('file:', urllib.pathname2url(path))


data = dict()
data["terminate"] = False


args = sys.argv

if len(args) != 2:
    print "Invalid number of arguments"
    sys.exit(0)

path = args[1]

pipeline = gst.parse_launch("playbin2 uri="+path2url(path)) 
# pipeline = gst.parse_launch("playbin2 uri=http://docs.gstreamer.com/media/sintel_trailer-480p.webm") 


def stop(signal, frame):
    pipeline.set_state(gst.STATE_READY)
    sys.exit(0)

def pause(signal, frame):
    pipeline.set_state(gst.STATE_PAUSED)

def unpause(signal, frame):
    pipeline.set_state(gst.STATE_PLAYING)


signal.signal(signal.SIGINT, stop)
signal.signal(signal.SIGBUS, pause)
signal.signal(signal.SIGURG, unpause)

# Build the pipeline
# pipeline = gst.parse_launch("playbin2 uri=http://docs.gstreamer.com/media/sintel_trailer-480p.webm")

# Start playing
pipeline.set_state(gst.STATE_PLAYING)

# Wait until error or EOS
#msg = bus.timed_pop_filtered(gst.CLOCK_TIME_NONE, gst.MESSAGE_ERROR | gst.MESSAGE_EOS)



def handle_message(data, msg):
    if message.type == gst.MESSAGE_ERROR:
        err, debug = message.parse_error()
        data["terminate"] = True
    elif message.type == gst.MESSAGE_EOS:
        data["terminate"] = True
    elif message.type == gst.MESSAGE_DURATION:
        data["duration"] = gst.CLOCK_TIME_NONE

bus = pipeline.get_bus()
while not data["terminate"]:
    #print pipeline.get_state()
    #time.sleep(1)
    message = bus.timed_pop_filtered(100 * gst.MSECOND,
                                     gst.MESSAGE_STATE_CHANGED | gst.MESSAGE_ERROR | gst.MESSAGE_EOS | gst.MESSAGE_DURATION)

    # Parse message
    if message:
        handle_message(data, message)

# Free resources
pipeline.set_state(gst.STATE_NULL)


