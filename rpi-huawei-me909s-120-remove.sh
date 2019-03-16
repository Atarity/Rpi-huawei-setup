#!/bin/bash
# Removing all files and settings made by rpi-huawei-me909s-120-setup.sh
# In case you no need to use modem anymore.

set -e
ifdown lte0
sleep 5

# Remove all configs and interfaces
rm /etc/udev/rules.d/99-huawei-wwan.rules
rm /etc/chatscripts/sunrise.HUAWEI
rm /etc/chatscripts/gsm_off.HUAWEI
rm /etc/network/interfaces.d/lte0

# Turn ON auto switching by usb_modeswitch
sudo sed -i '/^DisableSwitching/ s/1/0/' /etc/usb_modeswitch.conf

# Reboot
echo ""
echo "   Do you wish to restart now?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sudo reboot now;;
        No ) exit;;
    esac
done
