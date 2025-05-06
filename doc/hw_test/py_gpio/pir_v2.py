import RPi.GPIO as GPIO
import time
GPIO.setwarnings(False)
GPIO.setmode(GPIO.BOARD)
GPIO.setup(32, GPIO.IN)         #Read output from PIR motion sensor
def on_detect(channel):
 if GPIO.input(channel):
    print('Input was HIGH')
 else:
    print('Input was LOW')
GPIO.add_event_detect(32,GPIO.BOTH,callback=on_detect)

print('Start state:')
on_detect(32)

print('')
message = input("Press enter to quit\n\n") # Run until someone presses enter
GPIO.cleanup() # Clean up
