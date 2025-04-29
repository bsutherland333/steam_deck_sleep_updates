This repository contains two shell scripts and two systemd services to improve the Steam Deck game update behavior. Specifically, this repo will make a Steam Deck wake up at 3am every day for updates, but only if a power cable is connected and the deck wasn't put to sleep with a game running. Updates are avoided if power isn't connected so there is no risk of the Deck overheating in its case or otherwise draining battery power, and updates are also avoided if a game is running so Steam doesn't log extra game time on Steam profiles and games aren't resumed inadvertently.

To be specific about what these files do, `set-wake-alarm.service` runs `set-wake-alarm.sh` just before the Deck goes to sleep, and `set-wake-alarm.sh` sets a RTC wake alarm for 3am if no game is running. It checks if a game is running by using `fuser` to see if any running processes are using files found in the default Steam installation directory. **If you have games installed in other locations, then you'll need to specify to check those directories as well.** `check-wake-alarm.service` runs `check-wake-alarm.sh` just after being woken up, and `check-wake-alarm.sh` will put the Deck back to sleep if the Deck was woken within seconds of the RTC wake time and is disconnected from power.

If anyone has any issues or suggested improvements (like additional game installation directories to check with the fuser command) then feel free to create a Github issue or pull request.

# Installation

To use, download and run `install.sh` on your Deck or run `bash <(curl -s https://raw.githubusercontent.com/bsutherland333/steam_deck_sleep_updates/refs/heads/main/install.sh)`. Once that is done, go to Steam download settings and set updates to be scheduled for 3am to 4am. Note that major SteamOS updates will delete both `.service` files and you will occasionally need to re-run the install script, similar to how Decky Loader needs occasional re-installation.

# Uninstallation

To remove these files, run `uninstall.sh` or `bash <(curl -s https://raw.githubusercontent.com/bsutherland333/steam_deck_sleep_updates/refs/heads/main/uninstall.sh)`.
