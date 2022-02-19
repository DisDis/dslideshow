#!/bin/sh
# Give the pi permission to use 3D acceleration.
sudo usermod -a -G render pi

# Ensure Wireless Operation
sudo rfkill unblock wlan

# ---=== Install packages ===---
# Wireless Access Point
sudo apt install hostapd dnsmasq
# Fonts
sudo apt install ttf-mscorefonts-installer fontconfig
# Utils
sudo apt install mc 

# Wifi AP check https://www.raspberryconnect.com/projects/65-raspberrypi-hotspot-accesspoints/157-raspberry-pi-auto-wifi-hotspot-switch-internet

sudo systemctl unmask hostapd

sudo systemctl disable hostapd
sudo systemctl disable dnsmasq

#sudo nano /etc/default/hostapd
#DAEMON_CONF="/etc/hostapd/hostapd.conf"
#sudo systemctl enable autohotspot.service
