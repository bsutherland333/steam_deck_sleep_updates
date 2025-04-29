#!/bin/sh

# Create directory for scripts, if it doesn't exist
# I use /home/root-scripts so the scripts and their parent directories are owned by root, but also
# not wiped during major system updates
sudo mkdir -p /home/root-scripts

# Download the scripts and services, if they don't exist
if [ ! -f /home/root-scripts/set-wake-alarm.sh ]; then
  sudo curl -L -o /home/root-scripts/set-wake-alarm.sh https://raw.githubusercontent.com/bsutherland333/steam_deck_sleep_updates/refs/heads/main/set-wake-alarm.sh
fi
if [ ! -f /home/root-scripts/check-wake-alarm.sh ]; then
  sudo curl -L -o /home/root-scripts/check-wake-alarm.sh https://raw.githubusercontent.com/bsutherland333/steam_deck_sleep_updates/refs/heads/main/check-wake-alarm.sh
fi
if [ ! -f /etc/systemd/system/set-wake-alarm.service ]; then
    sudo curl -L -o /etc/systemd/system/set-wake-alarm.service https://raw.githubusercontent.com/bsutherland333/steam_deck_sleep_updates/refs/heads/main/set-wake-alarm.service
fi
if [ ! -f /etc/systemd/system/check-wake-alarm.service ]; then
  sudo curl -L -o /etc/systemd/system/check-wake-alarm.service https://raw.githubusercontent.com/bsutherland333/steam_deck_sleep_updates/refs/heads/main/check-wake-alarm.service
fi

# Enable the systemd services
sudo systemctl daemon-reload
sudo systemctl enable set-wake-alarm.service
sudo systemctl enable check-wake-alarm.service
