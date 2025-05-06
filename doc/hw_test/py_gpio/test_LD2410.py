from  LD2410  import *
import time

radar = LD2410(port="/dev/ttyAMA0") # Replace <port> with your serial port. e.g "COM3" or "/dev/ttyS0" etc. 

radar.enable_engineering_mode() # Enable engineering mode to get full data

# You must call call start() before getting data, or you get nothing
radar.start() # Start the radar module

# Get 60 data frames
for _ in range(60):
	print(radar.get_data())
	time.sleep(1) # Radar module will keep running in the background, but we only retrieve the latest data every 1 second

radar.stop()
