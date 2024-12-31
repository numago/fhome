#!/usr/bin/env bash
#
# Enable or disable the touchpad while typing on GNOME.

if [ $# -ne 1 ]; then
  echo "Usage: $0 <enable|disable>"
  echo "Enables or disables the touchpad while typing on GNOME."
  exit 1
fi

if [ "$1" == "disable" ]; then
  gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing true
  echo "Touchpad disabled while typing."
elif [ "$1" == "enable" ]; then
  gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing false
  echo "Touchpad enabled while typing."
else
  echo "Invalid argument. Usage: $0 <enable|disable>"
  exit 1
fi

exit 0
