#!/bin/sh

# Clear current wake alarm, ensuring consistent behavior
echo 0 > /sys/class/rtc/rtc0/wakealarm
echo 0 > /tmp/last_wake_time

# Get wake time
now=$(date +%s)
wake_time=$(date -d '03:00' +%s)  # modify the wake time here
if [ "$wake_time" -lt "$now" ]; then
    # Shift time forward 24h, if time is in the past
    wake_time=$((wake_time + 86400))
fi

# Check whether a game is running
# Apppend alternate installation locations immediately after the current
# directory (separated with a space), if needed
if [[ -n "$(fuser /home/deck/.steam/steam/steamapps/common/* 2>/dev/null)" ]]; then
    echo "Game running, skipping wake alarm"
else
    echo $wake_time > /sys/class/rtc/rtc0/wakealarm
    echo $wake_time > /tmp/last_wake_time
    echo "Set RTC wake alarm for $(date -d "@$wake_time")"
fi

