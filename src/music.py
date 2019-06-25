#!/usr/bin/python
# -*- coding: "utf-8" -*-

from pyfirmata import Arduino, util 
import pyaudio
import wave
import time
import sys
arduino = Arduino('COM3') 


def callback5C(in_data, frame_count, time_info, status):
    data = wf5C.readframes(frame_count)
    return (data, pyaudio.paContinue)

def callback5E(in_data, frame_count, time_info, status):
    data = wf5E.readframes(frame_count)
    return (data, pyaudio.paContinue)

def callback5G(in_data, frame_count, time_info, status):
    data = wf5G.readframes(frame_count)
    return (data, pyaudio.paContinue)

def callback6C(in_data, frame_count, time_info, status):
    data = wf6C.readframes(frame_count)
    return (data, pyaudio.paContinue)


def callback6E(in_data, frame_count, time_info, status):
    data = wf6E.readframes(frame_count)
    return (data, pyaudio.paContinue)

def callback6G(in_data, frame_count, time_info, status):
    data = wf6G.readframes(frame_count)
    return (data, pyaudio.paContinue)




def set_stream(p, wf, note):
    callback = eval("callback" + note)
    return  p.open(format=p.get_format_from_width(wf.getsampwidth()),
                channels=wf.getnchannels(),
                rate=wf.getframerate(),
                output=True,
                stream_callback=callback)


def close_stream(note):
    eval("stream" + note).close()
    eval("wf" + note).close()
    eval("p" + note).terminate()


def get_values():
    start_values = {}
    for i in range(1,6):
        print i
        value = None
        while value is None:
            try:
                value = float(arduino.analog[i].read())
            except Exception:
                pass
        start_values[i] = value
    return start_values


string5C = False
string5E = False
string5G = False
string6C = False
string6E = False
string6G = False

iterator = util.Iterator(arduino) 
iterator.start() 
#arduino.analog[0].enable_reporting()
arduino.analog[1].enable_reporting()
arduino.analog[2].enable_reporting()
arduino.analog[3].enable_reporting()
arduino.analog[4].enable_reporting()
arduino.analog[5].enable_reporting()

start_values = get_values()
print start_values


while True:
    try:
        try:
#            u1 = float(arduino.analog[5].read())
            u2 = float(arduino.analog[1].read())
            u3 = float(arduino.analog[2].read())
            u4 = float(arduino.analog[3].read())
            u5 = float(arduino.analog[4].read())
            u6 = float(arduino.analog[5].read())
            print u2, start_values[1]
            # if u1>0.86:
                # string5C=True
            if u2 > 1.5*start_values[1]:
                string5E=True
            if u3 > 1.5*start_values[2]:
                string5G=True
            if u4 > 1.5*start_values[3]:
                string6C=True
            if u5 > 1.5*start_values[4]:
                string6E=True
            if u6 > 1.5*start_values[5]:
                string6G=True				
        except Exception:
            pass		
        if string5C:
            try:
                close_stream("5C")
            except NameError:
                pass
            wf5C = wave.open("C:\\Users\\Joanna\\Desktop\\music\\5C.wav", 'rb')
            stream5C = set_stream(pyaudio.PyAudio(), wf5C, "5C")
            stream5C.start_stream()
            string5C = False
        if string5E:
            try:
                close_stream("5E")
            except NameError:
                pass
            wf5E = wave.open("C:\\Users\\Joanna\\Desktop\\music\\5E.wav", 'rb')
            stream5E = set_stream(pyaudio.PyAudio(), wf5E, "5E")
            stream5E.start_stream()
            string5E = False
        if string5G:
            try:
                close_stream("5G")
            except NameError:
                pass
            wf5G = wave.open("C:\\Users\\Joanna\\Desktop\\music\\5G.wav", 'rb')
            stream5G = set_stream(pyaudio.PyAudio(), wf5G, "5G")
            stream5G.start_stream()
            string5G = False
        if string6C:
            try:
                close_stream("6C")
            except NameError:
                pass
            wf6C = wave.open("C:\\Users\\Joanna\\Desktop\\music\\6C.wav", 'rb')
            stream6C = set_stream(pyaudio.PyAudio(), wf6C, "6C")
            stream6C.start_stream()
            string6C=False
        if string6E:
            try:
                close_stream("6E")
            except NameError:
                pass
            wf6E = wave.open("C:\\Users\\Joanna\\Desktop\\music\\6E.wav", 'rb')
            stream6E = set_stream(pyaudio.PyAudio(), wf6E, "6E")
            stream6E.start_stream()
            string6E=False
        if string6G:
            try:
                close_stream("6G")
            except NameError:
                pass
            wf6G = wave.open("C:\\Users\\Joanna\\Desktop\\music\\6G.wav", 'rb')
            stream6G = set_stream(pyaudio.PyAudio(), wf6G, "6G")
            stream6G.start_stream()
            string6G=False

    except KeyboardInterrupt:
        sys.exit(1)

#close_stream("5C")
close_stream("5E")
close_stream("5G")
close_stream("6C")
close_stream("6E")
close_stream("6G")





