#!/usr/bin/python3
import RPi.GPIO as GPIO
import time
import subprocess
servoPIN = 17
GPIO.setmode(GPIO.BCM)
GPIO.setup(servoPIN, GPIO.OUT)

p = GPIO.PWM(servoPIN, 50) # GPIO 17 als PWM mit 50Hz
p.start(2.5) # Initialisierung


p.ChangeDutyCycle(6)
time.sleep(0.5)
p.ChangeDutyCycle(0)
time.sleep(0.5)
p.ChangeDutyCycle(7)
time.sleep(0.5)
p.ChangeDutyCycle(0)
time.sleep(10) # Warmup time Coffee
p.ChangeDutyCycle(8)
time.sleep(0.5)
p.ChangeDutyCycle(7)
time.sleep(0.5)
p.ChangeDutyCycle(0)
p.stop()
GPIO.cleanup()
print("Finished")
#subprocess.call("/home/pi/Scripts/lcd/lcd_temp.py", shell=True)