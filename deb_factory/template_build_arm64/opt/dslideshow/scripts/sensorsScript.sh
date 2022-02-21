#!/bin/sh
#format:
#<sensor name>=<value>
#example:
#temp=61.3'C
#sensors | grep "Package id 0"
vcgencmd measure_temp
