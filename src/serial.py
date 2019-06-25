# -*- coding: utf-8 -*-

import serial

port = "/dev/cu.usbmodem1411"
sio = serial.Serial(port, 9600)
sio.close()
sio.open()
sio.readline()
sio.write("Tak!".encode('ascii'))

N = 100

try:
    while N > 0:
        try:
            temp = float(sio.readline())
            print(temp)
            N -= 1
        except ValueError:
            pass
except KeyboardInterrupt:
    pass
finally:
    sio.close()
