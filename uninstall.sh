#!/bin/sh

# Disable systemd services
sudo systemctl disable set-wake-alarm.service
sudo systemctl disable check-wake-alarm.service

# Remove all files
sudo rm /etc/systemd/system/set-wake-alarm.service /etc/systemd/system/check-wake-alarm.service
sudo rm /home/root-scripts/set-wake-alarm.sh /home/root-scripts/check-wake-alarm.sh

# Remove root-scripts directory, if empty
sudo rmdir /home/root-scripts
