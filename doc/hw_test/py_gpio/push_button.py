import RPi.GPIO as GPIO # Import Raspberry Pi GPIO library
def button_callback(channel):
    print("Button was pushed!")
GPIO.setwarnings(False) # Ignore warning for now
GPIO.setmode(GPIO.BOARD) # Use physical pin numbering
GPIO.setup(11, GPIO.IN, pull_up_down=GPIO.PUD_UP) # Set pin 11 to be an input pin and set initial value to be pulled low (off)
GPIO.add_event_detect(11,GPIO.RISING,callback=button_callback) # Setup event on pin 10 rising edge
GPIO.setup(13, GPIO.IN, pull_up_down=GPIO.PUD_UP) # Set pin 13 to be an input pin and set initial value to be pulled low (off)
GPIO.add_event_detect(13,GPIO.RISING,callback=button_callback) # Setup event on pin 10 rising edge
GPIO.setup(15, GPIO.IN, pull_up_down=GPIO.PUD_UP) # Set pin 15 to be an input pin and set initial value to be pulled low (off)
GPIO.add_event_detect(15,GPIO.RISING,callback=button_callback) # Setup event on pin 10 rising edge
GPIO.setup(16, GPIO.IN, pull_up_down=GPIO.PUD_UP) # Set pin 15 to be an input pin and set initial value to be pulled low (off)
GPIO.add_event_detect(16,GPIO.RISING,callback=button_callback) # Setup event on pin 10 rising edge


message = input("Press enter to quit\n\n") # Run until someone presses enter
GPIO.cleanup() # Clean up
