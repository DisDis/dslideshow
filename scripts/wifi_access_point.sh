#!/bin/sh
#https://www.raspberrypi.com/documentation/computers/configuration.html#setting-up-a-routed-wireless-access-point
#Enable the wireless access point service and set it to start when your Raspberry Pi boots:

sudo systemctl unmask hostapd
sudo systemctl enable hostapd
