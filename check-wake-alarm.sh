#!/bin/sh

# Check if last_wake_time file exists
[ -f "/tmp/last_wake_time" ] || { exit 0; }

# Check if woken seconds after wake time
now=$(date +%s)
wake_time=$(cat /tmp/last_wake_time)
if (( now > wake_time && now - wake_time < 3 )); then
    # Wait for resume to complete and power state to update, ensuring consistent behavior
    sleep 5

    # Check if device is running on battery
    if [ "$(cat /sys/class/power_supply/ACAD/online)" -eq 0 ]; then
        echo "Device on battery power after RTC wake alarm wakeup, suspending..."
        systemctl suspend
    fi
fi

