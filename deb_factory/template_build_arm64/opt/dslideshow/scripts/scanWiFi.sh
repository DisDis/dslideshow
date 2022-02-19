#!/bin/sh
WIFI_DEV="${1:-wlan0}" 
sudo iw $WIFI_DEV scan | grep 'SSID\|freq\:\|signal\|capability' | tac