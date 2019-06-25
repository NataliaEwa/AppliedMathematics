# -*- coding: utf-8 -*-

import serial
import matplotlib.pyplot as plt

port = "/dev/COM7"
sio = serial.Serial(port, 9600)
sio.close()
sio.open()
sio.readline()
sio.write("Tak!".encode('ascii'))

dane = [-100]*200

plt.ion()
fig = plt.figure()
linia, = plt.plot(dane)
plt.ylim([0, 40])

try:
    while True:
        try:
            temp = float(sio.readline())
            print(temp)
            dane = dane[1:]  # usuwamy 1 element
            dane.append(temp)  # dodajemy nowy na koĹcu
            linia.set_ydata(dane)
            plt.draw()
            plt.pause(0.001)
        except ValueError:
            pass
except KeyboardInterrupt:
    pass
finally:
    sio.close()
