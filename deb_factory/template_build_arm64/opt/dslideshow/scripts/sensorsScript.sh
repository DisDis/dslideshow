#!/bin/sh
#format:
#<sensor name>=<value>
#example:
#temp=61.3'C
#sensors | grep "Package id 0"
#Test sensors:
# echo "temp=61.3'C"
# echo "fan1=2000rpm"
# echo "fan2=0rpm"
# echo "button0=false"
# echo "button1=true"
# echo "human1=detected"
vcgencmd measure_temp
