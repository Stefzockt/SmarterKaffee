#!/usr/bin/env python3
import drivers
from time import sleep

display = drivers.Lcd()

try:
    
    for _ in range(12):
        file = open("/sys/bus/w1/devices/28-06201cbb8644/w1_slave")
        fcontent = file.read()
        string = fcontent.split("t=")
        temp = float(string[1])/1000
        print(temp)
        display.lcd_display_string(str(temp)+'C', 1)
        file.close()
        sleep(5)
        display.lcd_clear()                                
except KeyboardInterrupt:
    display.lcd_clear()

