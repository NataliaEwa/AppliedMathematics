import serial
import matplotlib.pyplot as plt
import ctypes

PORT = "COM3" 

def POP_UP_BOX(text):
    ctypes.windll.user32.MessageBoxA(0, text, "Uwaga!", 0)

if __name__ == "__main__":
	connection = serial.Serial(PORT, 9600) 
	connection.close() 
	connection.open() 
	
	plt.ion() 
	fig = plt.figure() 
	
	data_DS18B20 = [-100]*200
	data_MCP9700A = [-100]*200 
	
	line_DS18B20, = plt.plot(data_DS18B20) 
	line_MCP9700A, = plt.plot(data_MCP9700A)
	
	plt.ylim([0,40])
	
	device = 0
	while True:
		try: 
			temperature = float(connection.readline()) 
			if temperature==-2:
				POP_UP_BOX("Termometr zmieniono na MCP9700A")
				device = 0
			elif temperature==-1:
				POP_UP_BOX("Termometr zmieniono na DS18B20")
				device =1
			else:
				data_DS18B20 = data_DS18B20[1:]
				data_MCP9700A = data_MCP9700A[1:]
				if device==0:
					data_MCP9700A.append(temperature)
					data_DS18B20.append(None)
				elif device==1:
					data_DS18B20.append(temperature)
					data_MCP9700A.append(None)
				
				line_MCP9700A.set_ydata(data_MCP9700A)
				line_DS18B20.set_ydata(data_DS18B20)
				plt.draw()
		except KeyboardInterrupt:
			break
		except Exception: 
			pass 
		
	connection.close()