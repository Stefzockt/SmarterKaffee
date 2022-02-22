#!/usr/bin/python
import sys
from datetime import datetime
import subprocess

time = str(sys.argv[1] + " " + sys.argv[2])
fertig = False
startpara = datetime.strptime(time, '%y/%m/%d %H:%M')
starttime = startpara.time().strftime("%H:%M")
startdate = startpara.date()
try:
    while not fertig:
        now = datetime.now()
        current_time = now.strftime("%H:%M")
        current_date = now.date()
        if starttime == current_time and startdate == current_date:
            subprocess.call("/home/pi/SmarterKaffee/Scripts/Startcoffee.py", shell=True)
            fertig = True
except:KeyboardInterrupt
