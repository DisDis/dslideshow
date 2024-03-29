#!/bin/sh
# Give the pi permission to use 3D acceleration.
sudo usermod -a -G render pi

sudo usermod -a -G gpio pi

# Ensure Wireless Operation
sudo rfkill unblock wlan

# ---=== Install packages ===---
# Wireless Access Point
sudo apt install hostapd dnsmasq
# Fonts
sudo apt install ttf-mscorefonts-installer fontconfig
# DRM
sudo apt install libgl1-mesa-dev libgles2-mesa-dev libegl1-mesa-dev libdrm-dev libgbm-dev libsystemd-dev libinput-dev libudev-dev  libxkbcommon-dev
# Utils
sudo apt install mc screen

# Wifi AP check https://www.raspberryconnect.com/projects/65-raspberrypi-hotspot-accesspoints/157-raspberry-pi-auto-wifi-hotspot-switch-internet

#sudo systemctl unmask hostapd

#sudo systemctl disable hostapd
#sudo systemctl disable dnsmasq

#sudo nano /etc/default/hostapd
#DAEMON_CONF="/etc/hostapd/hostapd.conf"
#sudo systemctl enable autohotspot.service
